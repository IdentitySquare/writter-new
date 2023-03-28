# == Schema Information
#
# Table name: publications
#
#  id         :bigint           not null, primary key
#  bio        :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Publication < ApplicationRecord
  has_many :publication_users, dependent: :destroy
  has_many :users, through: :publication_users

  has_many :posts, dependent: :nullify

  has_many :received_follows, as: :followable, class_name: "Follow", dependent: :destroy
  has_many :followers, through: :received_follows, source: :user

  attr_accessor :user_email, :editor_emails, :invited_by, :admin_emails

  after_update :add_users

  def add_users
    revised_emails = editor_emails.split(',')
    existing_emails =  Publication.first.editors.pluck(:email)
    removed_emails = existing_emails - revised_emails
    
    revised_emails.each do |email|
      next if publication_users.where(user: User.find_by(email: email)).any?
      
      PublicationUser.create(publication: self, email: email, invited_by:,  role: 'editor')
    end

    removed_emails.each do |email|
      publication_users.find_by(user: User.find_by(email: email)).destroy
    end

    revised_emails = admin_emails.split(',')
    existing_emails =  Publication.first.admins.pluck(:email)
    removed_emails = existing_emails - revised_emails
    
    
    removed_emails.each do |email|
      publication_users.find_by(user: User.find_by(email: email)).destroy
    end

    admin_emails.split(',').each do |email|
      next if publication_users.where(user: User.find_by(email: email)).any?

      PublicationUser.create(publication: self, email: email, invited_by:,  role: 'admin')
    end
  end

  def editors
    publication_users.includes(:user).where(role: :editor)
  end

  def admins
    publication_users.includes(:user).where(role: :admin)
  end

  def members
    publication_users.includes(:user)
  end
end

  

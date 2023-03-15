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
  has_many :publication_users
  has_many :users, through: :publication_users

  attr_accessor :user_email, :editor_emails, :invited_by, :admin_emails

  after_update :add_users

  def add_users
    editor_emails.split(',').each do |email|
      # next if publication_users.where(email: email).present?

      PublicationUser.create(publication: self, email: email, invited_by:,  role: 'editor')
    end
    debugger
    admin_emails.split(',').each do |email|
      # next if publication_users.where(email: email).present?

      PublicationUser.create(publication: self, email: email, invited_by:,  role: 'admin')
    end
  end

  def editors
    publication_users.includes(:user).where(role: :editor)
  end

  def admins
    publication_users.includes(:user).where(role: :admin)
  end
end

  

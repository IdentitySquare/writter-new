class Publication < ApplicationRecord
  has_many :publication_users
  has_many :users, through: :publication_users

  attr_accessor :user_email, :editor_emails, :invited_by

  after_update :add_users

  def add_users
    editor_emails.split(',').each do |email|
      # next if publication_users.where(email: email).present?

      PublicationUser.create(publication: self, email: email, invited_by:,  role: 'editor')
    end
  end
end

  
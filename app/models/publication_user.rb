# == Schema Information
#
# Table name: publication_users
#
#  id             :bigint           not null, primary key
#  role           :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  publication_id :bigint           not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_publication_users_on_publication_id  (publication_id)
#  index_publication_users_on_user_id         (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (publication_id => publications.id)
#  fk_rails_...  (user_id => users.id)
#
class PublicationUser < ApplicationRecord
  
  #------- RELATIONS -------#
  belongs_to :user
  belongs_to :publication

  #------- ENUMS -------#
  enum role: { admin: 0, editor: 1 }

  attr_accessor :email, :executor

  #------- CALLBACKS -------#
  before_validation :set_user
  after_create :send_mail, unless: -> { executor == user_id}

  after_create :create_notification, unless: -> { executor == user_id}
  after_destroy :create_removed_notification, unless: -> { executor == user_id}

  def create_removed_notification
    
    Notification.create(notifiable: publication, user: user, sender: User.find(executor), notification_type: "#{role}_removed_from_publication")
  end

  def create_notification
    Notification.create(notifiable: publication, user: user,sender: User.find(executor), notification_type: "#{role}_added_to_publication")
  end

  def set_user
    return if user_id.present?

    # self.user = User.with_deleted.where(email: email)&.first
    self.user = User.where(email: email)&.first
    # User.restore(user.id) if user&.deleted?
    
    if user.blank?

      new_user = User.invite!({ email: email }, User.find(executor)) do |u|
        u.skip_invitation = true
      end
      raw_invitation_token = new_user.raw_invitation_token

      self.user = new_user
    end
  end

  def send_mail
    if user.pending_acceptance?
      PublicationUserMailer.with(user: user, publication: publication, role: role).invited_to_join.deliver_now
    else
      PublicationUserMailer.with(user: user, publication: publication, role: role).added_to_publication.deliver_now
    end
  end
end

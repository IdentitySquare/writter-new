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

  attr_accessor :email, :invited_by

  #------- CALLBACKS -------#
  before_validation :set_user
  after_create :send_mail

  def set_user
    debugger
    return if user_id.present?

    # self.user = User.with_deleted.where(email: email)&.first
    self.user = User.where(email: email)&.first
    # User.restore(user.id) if user&.deleted?
    
    if user.blank?
      new_user = User.invite!({ email: email }, User.find(invited_by)) do |u|
        u.skip_invitation = true
      end
      self.user = new_user
    end
  end

  def send_mail
    debugger
    if pending_invite?
      PublicationUserMailer.with(user: user, publication: publication, role: role).invited_to_join.deliver_now
    else
      PublicationUserMailer.with(user: user, publication: publication, role: role).added_to_publication.deliver_now
    end
  end

  def pending_invite?
    user.pending_invite?
  end

end

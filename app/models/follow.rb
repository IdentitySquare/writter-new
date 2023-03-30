# == Schema Information
#
# Table name: follows
#
#  id              :bigint           not null, primary key
#  followable_type :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  followable_id   :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_follows_on_followable                                     (followable_type,followable_id)
#  index_follows_on_user_id                                        (user_id)
#  index_follows_on_user_id_and_followable_type_and_followable_id  (user_id,followable_type,followable_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Follow < ApplicationRecord
  belongs_to :user
  belongs_to :followable, polymorphic: true

  after_create :create_notification
  before_destroy :destroy_notification

  private

  def create_notification
    Notification.create(notifiable: user, user: followable, text: 'followed', sender: user)
  end

  def destroy_notification
    Notification.where(notifiable: user)
                .where(user: followable)
                .where(text: 'followed')
                .where(sender: user)
                .first
                .destroy
  end


end

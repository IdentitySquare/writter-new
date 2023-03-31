# == Schema Information
#
# Table name: notifications
#
#  id                :bigint           not null, primary key
#  notifiable_type   :string           not null
#  notification_type :integer
#  read_at           :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  notifiable_id     :bigint           not null
#  sender_id         :bigint
#  user_id           :bigint           not null
#
# Indexes
#
#  index_notifications_on_notifiable  (notifiable_type,notifiable_id)
#  index_notifications_on_sender_id   (sender_id)
#  index_notifications_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notifiable, polymorphic: true, required: true
  belongs_to :sender, class_name: 'User', optional: true
  after_create_commit -> { broadcast_render_to("notifications_#{user.id}",partial: "notifications/create", locals: { notification: self, unread_count: user.notifications.unread.size }) }

  after_create :send_email, if: -> { user.notifications_freq == 'instantly' }
  
  enum notification_type: { comment_added: 0, 
                            post_removed_from_publication: 1,
                            editor_removed_from_publication: 2,
                            editor_added_to_publication: 3,
                            admin_added_to_publication: 4,
                            followed: 4}
  #scope for unread notifications
  scope :unread, -> { where(read_at: nil) }
    
  #display text for notification
  def display_text
    display = {"comment_added"  => "left a comment on your post",
               "post_removed_from_publication" => "removed your post from a publication",
               "editor_removed_from_publication" => "Someone removed you as an editor from the publication",
               "editor_added_to_publication" => "Someone added you as an editor to the publication",
               "admin_added_to_publication" => "Someone added you as an admin to the publication",
               "followed" => "started following you"
              }

    display[notification_type]
  end

  def send_email
    NotificationsMailer.with(mailer_params).instantly_mail.deliver_now
  end

  def mailer_params
    { 
      user_id: user.id,
      notification_id: self.id
    }
  end

  def seen?
    read_at.present?
  end

  def unseen?
    read_at.nil?
  end
end

class RenameNotificationsToEmailNotifications < ActiveRecord::Migration[7.0]
  def change
    # 1. Create a new column
    add_column :users, :email_notifications, :boolean, default: false

    # 2. Backfill data from the old column to new column
    User.all.each do |user|
      user.email_notifications = user.notifications
      user.save
    end

    # 3. Drop the old column
    safety_assured { remove_column :users, :notifications }
  end

end
class AddDefaultValuesForNotifications < ActiveRecord::Migration[7.0]
  def change
    change_column_default(
      :users,
      :email_notifications,
      from: false,
      to: true
    )

    change_column_default(
      :users,
      :notifications_freq,
      from: 0,
      to: 1
    )
  end
end

class DeleteTextColumn < ActiveRecord::Migration[7.0]
  def change
    # delete text column from notifications table
    safety_assured { remove_column :notifications, :text }

    # add notification_type column to notifications table
    add_column :notifications, :notification_type, :integer
  end
end

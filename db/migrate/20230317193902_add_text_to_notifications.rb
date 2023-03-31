class AddTextToNotifications < ActiveRecord::Migration[7.0]
  def change
    add_column :notifications, :text, :string
  end
end

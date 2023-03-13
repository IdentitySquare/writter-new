class AddNotificationColumnsForUsers < ActiveRecord::Migration[7.0]
  # add enum columns 
  def change
    add_column :users, :notifications, :boolean, default: true
    add_column :users, :notifications_freq, :integer, default: 0
    add_column :users, :new_article_notifications_freq, :integer, default: 0
    add_column :users, :performance_notifications_freq, :integer, default: 0
    add_column :users, :product_notifications, :boolean, default: true
  end
end

class AddSenderToNotifications < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_reference :notifications, :sender, references: :users, index: {algorithm: :concurrently}
  end
end
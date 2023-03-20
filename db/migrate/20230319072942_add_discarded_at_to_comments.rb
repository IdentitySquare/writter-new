class AddDiscardedAtToComments < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_column :comments, :discarded_at, :datetime
    add_index :comments, :discarded_at, algorithm: :concurrently
  end
end
class AddDiscardedAtToPosts < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_column :posts, :discarded_at, :datetime
    add_index :posts, :discarded_at, algorithm: :concurrently
  end
end

class CreateFollows < ActiveRecord::Migration[7.0]
  def change
    create_table :follows do |t|
      t.references :user, null: false, foreign_key: true
      t.references :followable, polymorphic: true, null: false
      t.index [:user_id, :followable_type, :followable_id ], unique: true

      t.timestamps
    end
  end
end

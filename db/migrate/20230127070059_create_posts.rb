class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|

      t.timestamps
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :body
      t.integer :status, default: 0, null: false   
    end
  end
end

class CreatePublicationUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :publication_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :publication, null: false, foreign_key: true
      t.integer :role

      t.timestamps
    end
  end
end

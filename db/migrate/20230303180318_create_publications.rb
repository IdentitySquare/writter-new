class CreatePublications < ActiveRecord::Migration[7.0]
  def change
    create_table :publications do |t|
      t.string :name
      t.string :bio

      t.timestamps
    end
  end
end

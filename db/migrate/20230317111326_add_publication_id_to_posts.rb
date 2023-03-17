class AddPublicationIdToPosts < ActiveRecord::Migration[7.0]
  # with safety_assured
  def change
    safety_assured { 
      change_table(:posts) do |t|
        t.references :publication, foreign_key: true
      end
    }
  end
end


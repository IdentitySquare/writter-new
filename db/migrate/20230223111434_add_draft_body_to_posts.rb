class AddDraftBodyToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :draft_body, :string
  end
end

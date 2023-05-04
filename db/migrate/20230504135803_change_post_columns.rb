class ChangePostColumns < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :published_title, :string
    add_column :posts,:draft_title, :string
    safety_assured { remove_column :posts, :body, :string }
    safety_assured { remove_column :posts, :title, :string }
    safety_assured { remove_column :posts, :draft_body}
   
  end
end

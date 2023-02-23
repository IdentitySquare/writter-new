class PopulateDraftBody < ActiveRecord::Migration[7.0]
  def change
    Post.where(draft_body: nil).each do |post|
      post.update(draft_body: post.body)
    end
  end
end

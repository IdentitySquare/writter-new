# == Schema Information
#
# Table name: comments
#
#  id           :bigint           not null, primary key
#  body         :string
#  discarded_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  post_id      :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_comments_on_discarded_at  (discarded_at)
#  index_comments_on_post_id       (post_id)
#  index_comments_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (post_id => posts.id)
#  fk_rails_...  (user_id => users.id)
#
class Comment < ApplicationRecord
  include Discard::Model
  # associations
  belongs_to :user
  belongs_to :post

  # validations
  validates :body, length: { maximum: 1000, message: "is too long (maximum is 1000 characters)" }
end

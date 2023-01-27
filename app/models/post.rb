# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  body       :text
#  status     :integer          default("draft"), not null
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Post < ApplicationRecord
    
  #----- CONSTANTS -----#
   enum status: { draft: 0, published: 1 }

   #----- ASSOCIATIONS -----#
   belongs_to :user
end

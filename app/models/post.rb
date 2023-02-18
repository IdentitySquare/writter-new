# == Schema Information
#
# Table name: posts
#
#  id           :bigint           not null, primary key
#  body         :text
#  published_at :datetime
#  status       :integer          default("draft"), not null
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
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


  def title
    return nil if empty?

    first_block = JSON.parse(body)&.fetch('blocks')[0]
    return first_block['data']['text'] if first_block&.fetch('type') == 'header'

    return nil
  end

  def body_content
    return nil if empty?

    block_index = title.present? ? 1 : 0

    body_block
  end

  def empty?
    return true if body.nil? || JSON.parse(body)&.fetch('blocks').empty?
  end

end

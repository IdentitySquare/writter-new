# == Schema Information
#
# Table name: follows
#
#  id            :bigint           not null, primary key
#  followee_type :string           not null
#  follower_type :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  followee_id   :bigint           not null
#  follower_id   :bigint           not null
#
# Indexes
#
#  index_follows_on_followee  (followee_type,followee_id)
#  index_follows_on_follower  (follower_type,follower_id)
#
class Follow < ApplicationRecord
  belongs_to :follower, class_name: :user
  belongs_to :followee, polymorphic: true
end

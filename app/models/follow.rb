# == Schema Information
#
# Table name: follows
#
#  id              :bigint           not null, primary key
#  followable_type :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  followable_id   :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_follows_on_followable                                     (followable_type,followable_id)
#  index_follows_on_user_id                                        (user_id)
#  index_follows_on_user_id_and_followable_type_and_followable_id  (user_id,followable_type,followable_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Follow < ApplicationRecord
  belongs_to :user
  belongs_to :followable, polymorphic: true
end

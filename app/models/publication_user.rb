# == Schema Information
#
# Table name: publication_users
#
#  id             :bigint           not null, primary key
#  role           :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  publication_id :bigint           not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_publication_users_on_publication_id  (publication_id)
#  index_publication_users_on_user_id         (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (publication_id => publications.id)
#  fk_rails_...  (user_id => users.id)
#
class PublicationUser < ApplicationRecord
  belongs_to :user
  belongs_to :publication
end

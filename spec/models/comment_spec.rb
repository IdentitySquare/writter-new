# == Schema Information
#
# Table name: posts
#
#  id             :bigint           not null, primary key
#  body           :text
#  draft_body     :string
#  published_at   :datetime
#  status         :integer          default("draft"), not null
#  title          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  publication_id :bigint
#  user_id        :bigint           not null
#
# Indexes
#
#  index_posts_on_publication_id  (publication_id)
#  index_posts_on_user_id         (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (publication_id => publications.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'
require 'spec_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_length_of(:body).is_at_most(1000) }
  end
end

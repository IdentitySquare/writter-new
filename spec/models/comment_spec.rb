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

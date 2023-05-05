# == Schema Information
#
# Table name: posts
#
#  id              :bigint           not null, primary key
#  discarded_at    :datetime
#  draft_title     :string
#  published_at    :datetime
#  published_title :string
#  status          :integer          default("draft"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  publication_id  :bigint
#  user_id         :bigint           not null
#
# Indexes
#
#  index_posts_on_discarded_at    (discarded_at)
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

RSpec.describe Post, type: :model do
    describe 'associations' do
        it { should belong_to(:user) }
    end
end

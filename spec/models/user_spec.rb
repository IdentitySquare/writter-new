require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
  
  describe 'associations' do
    it { should have_many(:posts).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_length_of(:username).is_at_least(4).on(:update) }
  end
end

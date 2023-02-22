# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  avatar_url             :string
#  bio                    :string
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  location               :string
#  name                   :string
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  uid                    :string
#  unconfirmed_email      :string
#  username               :string
#  website                :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
  
  describe 'associations' do
    it { should have_many(:posts).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_length_of(:username).is_at_least(4).on(:update) }
  end

  describe 'followers' do
    before do
      @user = FactoryBot.create(:user)
      @followed_user = FactoryBot.create(:user)

      FactoryBot.create(:follow,
        user: @user,
        followable: @followed_user)
    end
    
    it 'calculates correct number of followers' do
      expect(@user.followers.count).to eq(0)
      expect(@followed_user.followers.count).to eq(1)
    end

    it 'calculates correct number of following' do
      expect(@user.following.count).to eq(1)
      expect(@followed_user.following.count).to eq(0)
    end

  end
end

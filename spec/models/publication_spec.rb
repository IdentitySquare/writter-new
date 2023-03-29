#
require 'rails_helper'
require 'spec_helper'

RSpec.describe Publication, type: :model do
  describe 'associations' do
    it { should have_many(:publication_users) }
    it { should have_many(:users).through(:publication_users) }
    it { should have_many(:posts).dependent(:nullify) }
    it { should have_many(:followers).through(:received_follows).source(:user) }
  end
 
  describe 'callbacks' do
    it { should callback(:add_users).after(:update) }
  end

  describe 'methods' do
    let!(:publication) { FactoryBot.create(:publication) }
    let!(:editor) { FactoryBot.create(:user) }
    let!(:admin) {FactoryBot.create(:publication) }
    before do
      @publication = FactoryBot.create(:publication)
      @user1 = FactoryBot.create(:user)
      @user2 = FactoryBot.create(:user)
      

    
      @editor = FactoryBot.create(:publication_user, publication: publication, user: @user1, role: 1)
      @admin = FactoryBot.create(:publication_user, publication: publication, user: @user2, role: 0)

    end

    describe '#editors' do
      it 'returns all editors' do
        expect(publication.editors).to eq([@editor])
      end
    end

    describe '#admins' do
      it 'returns all admins' do
        expect(publication.admins).to eq([@admin])
      end
    end

    describe '#members' do
      it 'returns all members' do
        expect(publication.members).to eq([@editor, @admin])
      end
    end
  end
end

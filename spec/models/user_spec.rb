require 'rails_helper'

RSpec.describe User, type: :model do
  let(:built_user) { build(:user) }
  let(:user_with_following) { create(:user_with_following) }
  let(:created_user) { create(:user) }
  let(:second_created_user) { create(:user) }

  context 'instance methods' do
    it '#full_name' do
      full_name = "#{built_user.first_name} #{built_user.last_name}"
      expect(built_user.full_name).to eq(full_name)
    end
    context '#follows?' do
      it 'is expected to return true' do
        following = user_with_following.following.last
        expect(user_with_following.follows?(following)).to be_truthy
      end
      it 'is expected to return false' do
        expect(user_with_following.follows?(created_user)).to be_falsey
      end
    end
    context '#follow(candidate)' do
      it 'is expected to return true' do
        expect(created_user.follow(second_created_user)).to be_truthy
      end
      it 'is expected to return false' do
        expect(user_with_following.follows?(created_user)).to be_falsey
      end
    end
  end
end

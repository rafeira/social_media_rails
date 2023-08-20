require 'rails_helper'

RSpec.describe User, type: :model do
  let(:built_user) { build(:user) }
  let(:user_with_following) { create(:user_with_following) }
  let(:created_user) { create(:user) }
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
    end
  end
  context 'validations' do
    context 'on create' do
      it { should validate_presence_of(:first_name).on(:create) }
      it { should validate_presence_of(:last_name).on(:create) }
    end
    context 'on update' do
      it { should_not validate_presence_of(:first_name).on(:update) }
      it { should_not validate_presence_of(:last_name).on(:update) }
    end
    context 'on destroy' do
      it { should_not validate_presence_of(:first_name).on(:destroy) }
      it { should_not validate_presence_of(:last_name).on(:destroy) }
    end
    it { should validate_length_of(:password).is_at_most(128).is_at_least(6) }
  end
end

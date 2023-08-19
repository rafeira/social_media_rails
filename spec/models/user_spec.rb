require 'rails_helper'

RSpec.describe User, type: :model do
  let(:built_user) { build(:user) }
  context 'instance methods' do
    it '#full_name' do
      full_name = "#{built_user.first_name} #{built_user.last_name}"
      expect(built_user.full_name).to eq(full_name)
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

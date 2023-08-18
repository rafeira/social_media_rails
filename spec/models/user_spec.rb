require 'rails_helper'

RSpec.describe User, type: :model do
  context 'instance methods' do
    it '#full_name' do
      user = create(:user)
      full_name = "#{user.first_name} #{user.last_name}"
      expect(user.full_name).to eq(full_name)
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
  end
end

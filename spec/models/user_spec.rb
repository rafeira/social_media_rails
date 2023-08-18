require 'rails_helper'

RSpec.describe User, type: :model do
  context 'instance methods' do
    it '#full_name' do
      user = create(:user)
      full_name = "#{user.first_name} #{user.last_name}"
      expect(user.full_name).to eq(full_name)
    end
  end
end

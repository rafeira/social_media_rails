require 'rails_helper'

RSpec.describe User, type: :model do
  context 'instance methods' do
    it 'should return full name' do
      user = User.new(first_name: 'Fulano', last_name: 'da Silva')
      expect(user.full_name).to eq('Fulano da Silva')
    end
  end
end

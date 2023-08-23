# frozen_string_literal: true

require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
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

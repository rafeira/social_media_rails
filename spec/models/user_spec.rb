# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:built_user) { build(:user) }
  let(:user_with_following) { create(:user_with_following) }
  let(:created_user) { create(:user) }
  let(:second_created_user) { create(:user) }
  let(:following) { user_with_following.following.last }
  context 'instance methods' do
    it '#full_name' do
      full_name = "#{built_user.first_name} #{built_user.last_name}"
      expect(built_user.full_name).to eq(full_name)
    end
    describe '#follows?(candidate)' do
      context 'when candidate is followed' do
        it 'is expected to return true' do
          expect(user_with_following.follows?(following)).to be_truthy
        end
      end
      context 'when candidate is not followed' do
        it { expect(created_user.follows?(second_created_user)).to be_falsey }
      end
    end
    describe '#follow(candidate)' do
      context 'when candidate is not followed' do
        it 'is expected to return true' do
          expect(created_user.follow(second_created_user)).to be_truthy
        end
        it 'is expected to increase following count from 0 to 1' do
          expect { created_user.follow(second_created_user) }.to change { created_user.following.count }.from(0).to(1)
        end
      end
      context 'when candidate is already followed' do
        it 'is expected to return false' do
          expect(user_with_following.follow(following)).to be_falsey
        end
        it 'is expected to not change following count' do
          expect { user_with_following.follow(following) }.not_to(change { created_user.following.count })
        end
      end
    end
  end
end

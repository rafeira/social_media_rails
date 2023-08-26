# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:built_user) { build(:user) }
  let(:user_with_following) { create(:user_with_following) }
  let(:created_user) { create(:user) }
  let(:second_created_user) { create(:user) }
  let(:following) { user_with_following.following.last }
  let(:user_with_one_like_to_post) { create(:user_with_one_like_to_post) }
  let(:post) { create(:post) }
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
      context 'when candidate is itself' do
        it 'is expected to return false' do
          expect(created_user.follow(created_user)).to be_falsey
        end
      end
    end
    describe '#unfollow(candidate)' do
      context 'when candidate is not followed' do
        it 'is expected to return false' do
          expect(created_user.unfollow(second_created_user)).to be_falsey
        end
        it 'is expected to not change following count' do
          expect { created_user.unfollow(second_created_user) }.not_to(change { created_user.following.count })
        end
      end
      context 'when candidate is followed' do
        it 'is expected to return true' do
          expect(user_with_following.unfollow(following)).to be_truthy
        end
        it 'is expected to decrease following count from 1 to 0' do
          expect { user_with_following.unfollow(following) }.to change { user_with_following.following.count }.from(1).to(0)
        end
      end
    end
    describe '#like(likeable)' do
      context 'when likeable is a post' do
        context 'and post is already liked' do
          it 'is expected to return false' do
            post = user_with_one_like_to_post.likes.last.likeable
            expect(user_with_one_like_to_post.like(post)).to be_falsey
          end
          it 'is expected to not change user and post likes count' do
            liked_post = user_with_one_like_to_post.likes.last.likeable
            expect {
              user_with_one_like_to_post.like(liked_post)
            }.to change { user_with_one_like_to_post.likes.count }.by(0)
             .and change { liked_post.likes.count }.by(0)
          end
        end
        context 'and post is not liked' do
          it 'is expected to return true' do
            expect(created_user.like(post)).to be_truthy
          end
          it 'is expected to increase user and post likes count from 0 to 1' do
            expect{
              created_user.like(post)
            }.to change { created_user.likes.count }.from(0).to(1)
            .and change { post.likes.count }.from(0).to(1)
          end
        end
      end
    end
    describe '#dislike(likeable)' do
      context 'when likeable is a post' do
        context 'and post is liked' do
          it 'is expected to return true' do
            post = user_with_one_like_to_post.likes.last.likeable
            expect(user_with_one_like_to_post.dislike(post)).to be_truthy
          end
          it 'is expected to decrease user and post likes by 1' do
            liked_post = user_with_one_like_to_post.likes.last.likeable
            expect {
              user_with_one_like_to_post.dislike(liked_post)
            }.to change { user_with_one_like_to_post.likes.count }.from(1).to(0)
             .and change { liked_post.likes.count }.from(1).to(0)
          end
        end
        context 'and post is not liked' do
          it 'is expected to return false' do
            expect(created_user.dislike(post)).to be_falsey
          end
          it 'is expected to not change user and post likes count' do
            expect{
              created_user.dislike(post)
            }.to change { created_user.likes.count }.by(0)
            .and change { post.likes.count }.by(0)
          end
        end
      end
    end
    describe '#likes?(likeable)' do
      context 'when likeable is a post' do
        context 'and post is liked' do
          it 'is expected to return true' do
            post = user_with_one_like_to_post.likes.last.likeable
            expect(user_with_one_like_to_post.likes?(post)).to be_truthy
          end
        end
        context 'and post is not liked' do
          it 'is expected to return false' do
            expect(created_user.likes?(post)).to be_falsey
          end
        end
      end
    end
  end
end

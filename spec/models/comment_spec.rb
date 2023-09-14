require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'scopes' do
    describe '#latest_first' do
      let!(:first_comment){ create(:comment_to_post, created_at: 3.days.ago) }
      let!(:second_comment){ create(:comment_to_post, created_at: 2.days.ago) }
      let!(:third_comment){ create(:comment_to_post, created_at: 1.day.ago) }
      it 'orders comments by creation date in descending order' do
        expect(Comment.latest_first.ids).to match_array([third_comment.id,second_comment.id,first_comment.id])
      end
    end
  end
end

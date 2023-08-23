# frozen_string_literal: true

module CommentsHelper
  def liked?(comment)
    comment.likes.where(user: current_user).last
  end
end

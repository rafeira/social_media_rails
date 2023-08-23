# frozen_string_literal: true

module PostsHelper
  def liked?(likes)
    likes.map do |like|
      return true if like.user == current_user
    end
    false
  end
end

# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :latest_comments_first, -> { latest_first }, as: :commentable, class_name: 'Comment'
  has_many :likes, as: :likeable

  accepts_nested_attributes_for :comments
end

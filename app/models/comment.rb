# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable

  scope :latest_first, -> { order(created_at: :desc) }
end

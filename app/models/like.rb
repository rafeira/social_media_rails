# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :likeable, polymorphic: true
  belongs_to :user
  validates :user, uniqueness: { scope: %i[likeable_type likeable_id], message: 'Combination already taken' }
end

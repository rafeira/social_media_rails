# frozen_string_literal: true

class UserConnection < ApplicationRecord
  belongs_to :requester, foreign_key: :solicitor_user_id, class_name: 'User'
  belongs_to :requested, foreign_key: :requested_user_id, class_name: 'User'

  validates :solicitor_user_id, uniqueness: { scope: :requested_user_id, message: 'already exists' }
  validate :different_foreign_keys

  private

  def different_foreign_keys
    return unless solicitor_user_id == requested_user_id

    errors.add(:base, "can't have requester and requested equals")
  end
end

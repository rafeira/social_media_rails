class UserConnection < ApplicationRecord
  belongs_to :requester, foreign_key: :solicitor_user_id, class_name: 'User'
  belongs_to :requested, foreign_key: :requested_user_id, class_name: 'User'

  validates :solicitor_user_id, uniqueness: { scope: :requested_user_id, message: "already exists" }
end

# frozen_string_literal: true

FactoryBot.define do
  factory :user_connection do
    requester { create(:user) }
    requested { create(:user) }
  end
end

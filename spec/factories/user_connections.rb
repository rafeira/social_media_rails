# frozen_string_literal: true

FactoryBot.define do
  factory :user_connection do
    requester { association(:user) }
    requested { association(:user) }
  end
end

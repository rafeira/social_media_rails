# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    transient do
      user_connections_quantity { 1 }
    end
    email { FFaker::Internet.email }
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    password { FFaker::Internet.password(6, 10) }
    trait :with_one_following do
      after(:create) do |user, evaluator|
        create_list(:user_connection, evaluator.user_connections_quantity, requester: user)
      end
    end
    factory :user_with_following, traits: [:with_one_following]
  end
end

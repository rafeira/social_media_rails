FactoryBot.define do
  factory :post do
    transient do
      like_quantity { 1 }
    end
    trait :with_likes do
      after(:create) do |post, evaluator|
        create_list(:like, evaluator.like_quantity, likeable: post)
      end
      after(:build) do |post, evaluator|
        build_list(:like, evaluator.like_quantity, likeable: post)
      end
    end
    title { FFaker::Lorem.sentence }
    description { FFaker::Lorem.paragraphs.join("\n\n") }
    user { association(:user) }
    factory :post_with_likes, traits: [:with_likes]
  end
end

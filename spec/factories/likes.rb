FactoryBot.define do
  factory :like do
    user { association(:user) }
    trait :to_post do
      likeable { association(:post) }
    end
    factory :like_to_post, traits: [:to_post]
  end
end

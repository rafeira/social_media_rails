FactoryBot.define do
  factory :like do
    user { create(:user) }
    trait :to_post do
      likeable { create(:post) }
    end
    factory :like_to_post, traits: [:to_post]
  end
end

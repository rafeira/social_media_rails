FactoryBot.define do
  factory :comment do
    description { FFaker::Lorem.paragraphs.join("\n\n") }
    user { association(:user) }
    trait :to_post do
      commentable { association(:post) }
    end
    factory :comment_to_post, traits: [:to_post]
  end
end

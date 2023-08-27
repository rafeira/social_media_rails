FactoryBot.define do
  factory :comment do
    description { FFaker::Lorem.paragraphs.join("\n\n") }
    user { create(:user) }
    trait :to_post do
      commentable { create(:post) }
    end
    factory :comment_to_post, traits: [:to_post]
  end
end

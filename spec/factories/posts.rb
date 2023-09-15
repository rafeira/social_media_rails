FactoryBot.define do
  factory :post do
    title { FFaker::Lorem.sentence }
    description { FFaker::Lorem.paragraphs.join("\n\n") }
    user { association(:user) }
  end
end

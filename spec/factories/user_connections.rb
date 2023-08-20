FactoryBot.define do
  factory :user_connection do
    requester { create(:user) }
    requested { create(:user) }
  end
end

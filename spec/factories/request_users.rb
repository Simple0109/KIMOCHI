FactoryBot.define do
  factory :request_user do
    association :request
    association :user
  end
end

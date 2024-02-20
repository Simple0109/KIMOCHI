FactoryBot.define do
  factory :request do
    take { Faker::Lorem.sentence }
    execution_date { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    image { nil }
    comment { Faker::Lorem.sentence }
    status { 0 }
    association :user
    association :group

    after(:create) do |request|
      create(:give, request: request)
    end
  end
end

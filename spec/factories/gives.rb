FactoryBot.define do
  factory :give do
    content { Faker::Lorem.sentence }
    deadline {  Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)}
    status { 0 }
    association :request
  end
end

FactoryBot.define do
  factory :user do
    provider { 'line' }
    uid { Faker::Internet.uuid }
    email { Faker::Internet.email }
    password {Faker::Internet.password}

    after(:create) do |user|
      create(:profile, user: user)
    end
  end
end

FactoryBot.define do
  factory :profile do
    name { Faker::Internet.username}
    role { 0 }
    association:user

    after(:build) do |profile|

      profile.avatar.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'test.png')),
        filename: 'test.png',
        content_type: 'image/png'
      )
    end
  end
end

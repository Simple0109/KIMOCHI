FactoryBot.define do
  factory :group do
    name { Faker::Team.name }
    description { Faker::Lorem.sentence }
    association :owner, factory: :user

    after(:create) do |group|
      create(:group_user, group: group, user: group.owner)
    end
  end
end

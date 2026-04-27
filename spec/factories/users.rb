FactoryBot.define do
  factory :user do
    sequence(:email_address) { |n| "user#{n}@example.com" }
    password { "password123" }
    username { Faker::Internet.unique.username(specifier: 5..20).gsub(/[^a-z0-9_]/, "_") }
    display_name { Faker::Name.name }
    theme { "classic" }
  end
end

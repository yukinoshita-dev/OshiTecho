FactoryBot.define do
  factory :oshi do
    user
    name { Faker::Name.name }
    category { "声優" }
    kana { "てすと" }
    color { "#ff6b9d" }
  end
end

FactoryBot.define do
  factory :notification do
    user
    association :actor, factory: :user
    action { "follow" }
    read_at { nil }
  end

  trait :read do
    read_at { Time.current }
  end
end

FactoryBot.define do
  factory :event do
    user
    oshi
    title { Faker::Lorem.sentence(word_count: 3) }
    event_date { Date.current + 7.days }
    event_type { :live }
    payment_status { :unpaid }
    transport { :none }
    visibility { :private_only }
  end

  trait :public do
    visibility { :public_visible }
  end

  trait :upcoming do
    event_date { Date.current + 1.day }
  end

  trait :past do
    event_date { Date.current - 1.day }
  end
end

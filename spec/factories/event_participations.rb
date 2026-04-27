FactoryBot.define do
  factory :event_participation do
    user
    event
    status { :planning }
  end
end

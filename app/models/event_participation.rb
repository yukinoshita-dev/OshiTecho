class EventParticipation < ApplicationRecord
  belongs_to :user
  belongs_to :event

  enum :status, { planning: 0, attended: 1, cancelled: 2 }

  validates :user_id, uniqueness: { scope: :event_id }
end

class Event < ApplicationRecord
  belongs_to :user
  belongs_to :oshi
  has_many :participations, class_name: "EventParticipation", dependent: :destroy

  enum :event_type, { live: 0, handshake: 1, talk: 2, online: 3, release: 4, other: 5 }
  enum :payment_status, { unpaid: 0, paid: 1, refunded: 2 }
  enum :transport, { none: 0, train: 1, bus: 2, car: 3, plane: 4, other_transport: 5 }
  enum :visibility, { private_only: 0, public_visible: 1 }

  validates :title, presence: true, length: { maximum: 200 }
  validates :event_date, presence: true
  validates :ticket_price, numericality: { greater_than_or_equal_to: 0, allow_nil: true }

  scope :upcoming, -> { where("event_date >= ?", Date.current).order(:event_date, :start_time) }
  scope :past,     -> { where("event_date < ?", Date.current).order(event_date: :desc) }
  scope :public_visible, -> { where(visibility: :public_visible) }
  scope :by_oshi, ->(oshi_id) { where(oshi_id: oshi_id) }
end

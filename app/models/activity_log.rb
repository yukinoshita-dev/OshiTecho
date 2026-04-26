class ActivityLog < ApplicationRecord
  belongs_to :user
  belongs_to :oshi,  optional: true
  belongs_to :event, optional: true
  has_many_attached :images

  enum :visibility, { private_only: 0, public_visible: 1 }

  RATINGS = (1..5).to_a.freeze

  validates :title,  presence: true, length: { maximum: 200 }
  validates :rating, inclusion: { in: [0] + RATINGS }
  validates :transport_cost,     numericality: { greater_than_or_equal_to: 0, allow_nil: true }
  validates :accommodation_cost, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
  validates :food_cost,          numericality: { greater_than_or_equal_to: 0, allow_nil: true }

  scope :ordered,        -> { order(created_at: :desc) }
  scope :public_visible, -> { where(visibility: :public_visible) }
  scope :by_oshi,        ->(oshi_id) { where(oshi_id: oshi_id) if oshi_id.present? }
  scope :by_rating,      ->(r) { where(rating: r) if r.present? }

  def total_cost
    (transport_cost || 0) + (accommodation_cost || 0) + (food_cost || 0)
  end
end

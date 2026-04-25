class OshiAnniversary < ApplicationRecord
  belongs_to :oshi

  validates :name, presence: true, length: { maximum: 100 }
  validates :date, presence: true

  scope :ordered, -> { order(:date) }
end

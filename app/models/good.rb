class Good < ApplicationRecord
  CATEGORIES = %w[CD BD フィギュア 写真 アパレル その他].freeze

  belongs_to :user
  belongs_to :oshi, optional: true
  has_one_attached :image

  validates :name,     presence: true, length: { maximum: 200 }
  validates :price,    numericality: { greater_than_or_equal_to: 0, allow_nil: true }
  validates :category, inclusion: { in: CATEGORIES }, allow_blank: true

  scope :ordered,       -> { order(purchase_date: :desc, created_at: :desc) }
  scope :by_oshi,       ->(oshi_id) { where(oshi_id: oshi_id) if oshi_id.present? }
  scope :by_category,   ->(cat) { where(category: cat) if cat.present? }
  scope :by_year_month, ->(ym) {
    if ym.present?
      year, month = ym.split("-").map(&:to_i)
      where(purchase_date: Date.new(year, month).beginning_of_month..Date.new(year, month).end_of_month)
    end
  }
end

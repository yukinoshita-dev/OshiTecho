class Oshi < ApplicationRecord
  belongs_to :user
  has_many :anniversaries, class_name: "OshiAnniversary", dependent: :destroy
  has_many :goods, dependent: :nullify
  has_one_attached :image

  accepts_nested_attributes_for :anniversaries, allow_destroy: true, reject_if: :all_blank

  CATEGORIES = %w[アイドル 声優 俳優 アーティスト Vtuber その他].freeze

  enum :status, { active: 0, graduated: 1, hiatus: 2 }

  validates :name, presence: true, length: { maximum: 100 }
  validates :color, format: { with: /\A#[0-9a-fA-F]{6}\z/, allow_blank: true }
  validates :hashtag, length: { maximum: 100 }
  validates :kana, length: { maximum: 100 }
  validates :note, length: { maximum: 1000 }
  validates :category, inclusion: { in: CATEGORIES }, allow_blank: true

  scope :ordered,         -> { order(:position, :created_at) }
  scope :by_kana,         -> { order(Arel.sql("COALESCE(NULLIF(kana, ''), name)")) }
  scope :by_category,     ->(cat) { where(category: cat) if cat.present? }
end

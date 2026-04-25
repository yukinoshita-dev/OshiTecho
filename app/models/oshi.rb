class Oshi < ApplicationRecord
  belongs_to :user
  has_many :anniversaries, class_name: "OshiAnniversary", dependent: :destroy
  has_one_attached :image

  accepts_nested_attributes_for :anniversaries, allow_destroy: true, reject_if: :all_blank

  enum :status, { active: 0, graduated: 1, hiatus: 2 }

  validates :name, presence: true, length: { maximum: 100 }
  validates :color, format: { with: /\A#[0-9a-fA-F]{6}\z/, allow_blank: true }
  validates :hashtag, length: { maximum: 100 }
  validates :note, length: { maximum: 1000 }

  scope :ordered, -> { order(:position, :created_at) }
end

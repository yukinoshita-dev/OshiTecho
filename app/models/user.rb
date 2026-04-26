class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :oshis, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :goods, dependent: :destroy
  has_many :activity_logs, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :event_participations, dependent: :destroy
  has_many :active_follows,  class_name: "Follow", foreign_key: :follower_id, dependent: :destroy
  has_many :passive_follows, class_name: "Follow", foreign_key: :followed_id, dependent: :destroy
  has_many :following, through: :active_follows,  source: :followed
  has_many :followers, through: :passive_follows, source: :follower
  has_one_attached :avatar

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :email_address, presence: true, uniqueness: { case_sensitive: false },
                            format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, uniqueness: { case_sensitive: false, allow_blank: true },
                       format: { with: /\A[a-z0-9_]+\z/, message: "は半角英数字とアンダースコアのみ使用できます", allow_blank: true },
                       length: { maximum: 30 }
  validates :display_name, length: { maximum: 50 }
  validates :bio, length: { maximum: 200 }

  THEMES = %w[classic girly natural cool].freeze
  validates :theme, inclusion: { in: THEMES }

  def follow(other)
    active_follows.find_or_create_by(followed: other) unless other == self
  end

  def unfollow(other)
    active_follows.find_by(followed: other)&.destroy
  end

  def following?(other)
    following.include?(other)
  end

  def ff?(other)
    following?(other) && other.following?(self)
  end
end

class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  THEMES = %w[classic girly natural cool].freeze
  validates :theme, inclusion: { in: THEMES }
end

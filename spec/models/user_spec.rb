require "rails_helper"

RSpec.describe User, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:sessions).dependent(:destroy) }
    it { is_expected.to have_many(:oshis).dependent(:destroy) }
    it { is_expected.to have_many(:events).dependent(:destroy) }
    it { is_expected.to have_many(:notifications).dependent(:destroy) }
    it { is_expected.to have_many(:active_follows).dependent(:destroy) }
    it { is_expected.to have_many(:passive_follows).dependent(:destroy) }
    it { is_expected.to have_many(:following) }
    it { is_expected.to have_many(:followers) }
  end

  describe "validations" do
    subject { build(:user) }

    it { is_expected.to validate_presence_of(:email_address) }
    it { is_expected.to validate_uniqueness_of(:email_address).case_insensitive }
    it { is_expected.to validate_length_of(:display_name).is_at_most(50) }
    it { is_expected.to validate_length_of(:bio).is_at_most(200) }
    it { is_expected.to validate_length_of(:username).is_at_most(30) }

    it "rejects invalid username format" do
      user = build(:user, username: "INVALID!")
      expect(user).not_to be_valid
      expect(user.errors[:username]).to be_present
    end

    it "accepts valid username format" do
      user = build(:user, username: "valid_user123")
      expect(user).to be_valid
    end
  end

  describe "#follow / #unfollow / #following?" do
    let(:user_a) { create(:user) }
    let(:user_b) { create(:user) }

    it "follows another user" do
      user_a.follow(user_b)
      expect(user_a.following?(user_b)).to be true
    end

    it "unfollows a user" do
      user_a.follow(user_b)
      user_a.unfollow(user_b)
      expect(user_a.following?(user_b)).to be false
    end

    it "does not follow self" do
      user_a.follow(user_a)
      expect(user_a.following?(user_a)).to be false
    end

    it "does not create duplicate follows" do
      expect {
        2.times { user_a.follow(user_b) }
      }.to change(Follow, :count).by(1)
    end
  end

  describe "#ff?" do
    let(:user_a) { create(:user) }
    let(:user_b) { create(:user) }

    it "returns true when mutual follow" do
      user_a.follow(user_b)
      user_b.follow(user_a)
      expect(user_a.ff?(user_b)).to be true
    end

    it "returns false when one-sided follow" do
      user_a.follow(user_b)
      expect(user_a.ff?(user_b)).to be false
    end
  end
end

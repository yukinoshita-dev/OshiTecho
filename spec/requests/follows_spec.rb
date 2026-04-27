require "rails_helper"

RSpec.describe "Follows", type: :request do
  let(:user)   { create(:user) }
  let(:target) { create(:user) }

  before { sign_in(user) }

  describe "POST /users/:user_id/follow" do
    it "creates a follow" do
      expect {
        post user_follow_path(target)
      }.to change(Follow, :count).by(1)
    end

    it "creates a notification for the target user" do
      expect {
        post user_follow_path(target)
      }.to change { target.notifications.count }.by(1)
    end

    it "does not create a notification when following self" do
      expect {
        post user_follow_path(user)
      }.not_to change(Notification, :count)
    end
  end

  describe "DELETE /users/:user_id/follow" do
    before { user.follow(target) }

    it "removes the follow" do
      expect {
        delete user_follow_path(target)
      }.to change(Follow, :count).by(-1)
    end
  end
end

require "rails_helper"

RSpec.describe "Notifications", type: :request do
  let(:user) { create(:user) }

  before { sign_in(user) }

  describe "GET /notifications" do
    it "returns http success" do
      create_list(:notification, 3, user: user)
      get notifications_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /notifications/mark_all_read" do
    it "marks all unread notifications as read" do
      create_list(:notification, 3, user: user)
      expect {
        patch mark_all_read_notifications_path
      }.to change { user.notifications.unread.count }.from(3).to(0)
    end

    it "redirects to notifications path" do
      patch mark_all_read_notifications_path
      expect(response).to redirect_to(notifications_path)
    end
  end
end

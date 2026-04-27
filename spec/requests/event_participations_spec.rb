require "rails_helper"

RSpec.describe "EventParticipations", type: :request do
  let(:owner)     { create(:user) }
  let(:attendee)  { create(:user) }
  let(:oshi)      { create(:oshi, user: owner) }
  let(:event)     { create(:event, user: owner, oshi: oshi) }

  before { sign_in(attendee) }

  describe "POST /events/:event_id/participations" do
    it "creates a participation" do
      expect {
        post event_participations_path(event)
      }.to change(EventParticipation, :count).by(1)
    end

    it "creates a notification for the event owner" do
      expect {
        post event_participations_path(event)
      }.to change { owner.notifications.count }.by(1)
    end

    it "does not notify when owner participates in own event" do
      sign_in(owner)
      expect {
        post event_participations_path(event)
      }.not_to change(Notification, :count)
    end
  end

  describe "DELETE /events/:event_id/participations/:id" do
    let!(:participation) { create(:event_participation, user: attendee, event: event) }

    it "destroys the participation" do
      expect {
        delete event_participation_path(event, participation)
      }.to change(EventParticipation, :count).by(-1)
    end
  end
end

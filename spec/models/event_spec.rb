require "rails_helper"

RSpec.describe Event, type: :model do
  describe "validations" do
    subject { build(:event) }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:event_date) }
    it { is_expected.to validate_length_of(:title).is_at_most(200) }
  end

  describe "scopes" do
    let!(:past_event)   { create(:event, :past) }
    let!(:future_event) { create(:event, :upcoming) }
    let!(:public_event) { create(:event, :public, :upcoming) }

    it "upcoming scope returns future events" do
      expect(Event.upcoming).to include(future_event, public_event)
      expect(Event.upcoming).not_to include(past_event)
    end

    it "past scope returns past events" do
      expect(Event.past).to include(past_event)
      expect(Event.past).not_to include(future_event)
    end

    it "public_visible scope returns only public events" do
      expect(Event.public_visible).to include(public_event)
      expect(Event.public_visible).not_to include(future_event)
    end
  end
end

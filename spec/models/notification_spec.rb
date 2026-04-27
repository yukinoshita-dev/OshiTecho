require "rails_helper"

RSpec.describe Notification, type: :model do
  describe "scopes" do
    let!(:unread) { create(:notification) }
    let!(:read)   { create(:notification, :read) }

    it "unread scope returns only unread" do
      expect(Notification.unread).to include(unread)
      expect(Notification.unread).not_to include(read)
    end

    it "ordered scope returns newest first" do
      expect(Notification.ordered.first.created_at).to be >= Notification.ordered.last.created_at
    end
  end

  describe "#read?" do
    it "returns false when read_at is nil" do
      notification = build(:notification, read_at: nil)
      expect(notification.read?).to be false
    end

    it "returns true when read_at is set" do
      notification = build(:notification, :read)
      expect(notification.read?).to be true
    end
  end

  describe "#mark_as_read!" do
    it "sets read_at" do
      notification = create(:notification)
      expect { notification.mark_as_read! }.to change { notification.read_at }.from(nil)
    end

    it "does not update already read notification" do
      read_at = 1.hour.ago
      notification = create(:notification, read_at: read_at)
      notification.mark_as_read!
      expect(notification.read_at.to_i).to eq(read_at.to_i)
    end
  end

  describe "#message" do
    let(:actor) { build(:user, display_name: "テスト花子") }

    it "returns follow message" do
      notification = build(:notification, actor: actor, action: "follow")
      expect(notification.message).to eq("テスト花子 さんにフォローされました")
    end

    it "returns participation message" do
      notification = build(:notification, actor: actor, action: "participation")
      expect(notification.message).to eq("テスト花子 さんがあなたのイベントに参加表明しました")
    end

    it "returns action string for unknown action" do
      notification = build(:notification, actor: actor, action: "unknown_action")
      expect(notification.message).to eq("unknown_action")
    end

    it "uses email prefix when display_name is blank" do
      actor.display_name = nil
      actor.email_address = "test@example.com"
      notification = build(:notification, actor: actor, action: "follow")
      expect(notification.message).to include("test")
    end
  end
end

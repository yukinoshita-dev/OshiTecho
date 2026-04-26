class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :actor, class_name: "User", optional: true
  belongs_to :notifiable, polymorphic: true, optional: true

  scope :unread,   -> { where(read_at: nil) }
  scope :ordered,  -> { order(created_at: :desc) }

  def read?
    read_at.present?
  end

  def mark_as_read!
    update!(read_at: Time.current) unless read?
  end

  def message
    actor_name = actor&.display_name.presence || actor&.email_address&.split("@")&.first || "誰か"
    case action
    when "follow"          then "#{actor_name} さんにフォローされました"
    when "participation"   then "#{actor_name} さんがあなたのイベントに参加表明しました"
    when "event_reminder"  then "明日「#{notifiable&.title}」があります"
    else action
    end
  end
end

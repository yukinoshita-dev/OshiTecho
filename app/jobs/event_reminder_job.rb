class EventReminderJob < ApplicationJob
  queue_as :default

  def perform
    tomorrow = Date.current + 1.day
    events = Event.where(event_date: tomorrow).includes(participations: :user)

    events.each do |event|
      event.participations.planning.each do |participation|
        participation.user.notifications.create!(
          actor: nil,
          notifiable: event,
          action: "event_reminder"
        )
      end
    end
  end
end

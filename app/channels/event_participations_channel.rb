class EventParticipationsChannel < ApplicationCable::Channel
  def subscribed
    event = Event.find_by(id: params[:event_id])
    stream_for event if event
  end

  def unsubscribed
  end
end

class EventParticipationsController < ApplicationController
  before_action :set_event

  def create
    @participation = @event.participations.find_or_initialize_by(user: Current.user)
    @participation.status = params[:status] || :planning
    @participation.save!

    if @event.user != Current.user
      @event.user.notifications.create!(
        actor: Current.user,
        notifiable: @participation,
        action: "participation"
      )
    end

    broadcast_participation_count

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: events_path }
    end
  end

  def destroy
    @participation = @event.participations.find_by!(user: Current.user)
    @participation.destroy

    broadcast_participation_count

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: events_path }
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def broadcast_participation_count
    @event.participations.reload
    EventParticipationsChannel.broadcast_to(
      @event,
      html: render_to_string(
        partial: "event_participations/participation_count",
        locals: { event: @event }
      )
    )
  end
end

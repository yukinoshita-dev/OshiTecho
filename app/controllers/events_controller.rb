class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :export_ical]

  def index
    @oshi = Current.user.oshis.find_by(id: params[:oshi_id])
    scope = Current.user.events.includes(:oshi)
    scope = scope.by_oshi(@oshi.id) if @oshi
    scope = params[:past] == "1" ? scope.past : scope.upcoming
    @events = scope
  end

  def show
  end

  def new
    @event = Current.user.events.build
    @event.oshi_id = params[:oshi_id] if params[:oshi_id]
    @oshis = Current.user.oshis.ordered
  end

  def create
    @event = Current.user.events.build(event_params)
    if @event.save
      redirect_to events_path, notice: "イベントを登録しました"
    else
      @oshis = Current.user.oshis.ordered
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @oshis = Current.user.oshis.ordered
  end

  def update
    if @event.update(event_params)
      redirect_to events_path, notice: "イベントを更新しました"
    else
      @oshis = Current.user.oshis.ordered
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: "イベントを削除しました", status: :see_other
  end

  def export_ical
    cal = Icalendar::Calendar.new
    cal.prodid = "-//推し手帳//JP"

    event = Icalendar::Event.new
    event.dtstart     = Icalendar::Values::Date.new(@event.event_date)
    event.dtend       = Icalendar::Values::Date.new(@event.event_date + 1)
    event.summary     = @event.title
    event.description = [@event.oshi&.name, @event.venue, @event.note].compact.join("\n")
    event.location    = @event.venue if @event.venue.present?
    event.uid         = "event-#{@event.id}@oshi-techo"

    if @event.start_time.present?
      start_dt = Time.zone.parse("#{@event.event_date} #{@event.start_time}")
      event.dtstart = Icalendar::Values::DateTime.new(start_dt)
      event.dtend   = @event.end_time.present? ?
        Icalendar::Values::DateTime.new(Time.zone.parse("#{@event.event_date} #{@event.end_time}")) :
        Icalendar::Values::DateTime.new(start_dt + 2.hours)
    end

    cal.add_event(event)
    cal.publish

    send_data cal.to_ical,
              filename: "event_#{@event.id}.ics",
              type: "text/calendar; charset=utf-8",
              disposition: "attachment"
  end

  private

  def set_event
    @event = Current.user.events.find(params[:id])
  end

  def event_params
    params.require(:event).permit(
      :oshi_id, :title, :event_type, :venue, :event_date,
      :open_time, :start_time, :end_time,
      :ticket_price, :payment_status, :seat,
      :expedition, :transport, :note, :visibility
    )
  end
end

class CalendarsController < ApplicationController
  def show
  end

  def events
    events_data = []

    # 自分のイベント
    Current.user.events.includes(:oshi).each do |event|
      color = event.oshi&.color || "#6366f1"
      events_data << {
        id:    "event-#{event.id}",
        title: event.title,
        start: event.event_date.to_s,
        color: color,
        extendedProps: {
          type:   "event",
          oshi:   event.oshi&.name,
          venue:  event.venue,
          status: event.visibility,
          url:    event_path(event)
        }
      }
    end

    # FFのイベント（公開のみ）
    following_ids = Current.user.active_follows.pluck(:followed_id)
    follower_ids  = Current.user.passive_follows.pluck(:follower_id)
    ff_ids = following_ids & follower_ids
    if ff_ids.any?
      Event.public_visible
           .where(user_id: ff_ids)
           .includes(:oshi, :user)
           .each do |event|
        color = event.oshi&.color || "#94a3b8"
        events_data << {
          id:    "ff-event-#{event.id}",
          title: "#{event.user.display_name.presence || event.user.email_address.split('@').first}: #{event.title}",
          start: event.event_date.to_s,
          color: color,
          textColor: "#ffffff",
          borderColor: darken(color),
          extendedProps: {
            type:  "ff_event",
            oshi:  event.oshi&.name,
            venue: event.venue,
            user:  event.user.display_name.presence || event.user.email_address.split('@').first
          }
        }
      end
    end

    # 自分の推しの記念日（yearly=trueは毎年展開）
    current_year = Date.current.year
    Current.user.oshis.includes(:anniversaries).each do |oshi|
      oshi.anniversaries.each do |ann|
        dates = ann.yearly ? [ann.date.change(year: current_year), ann.date.change(year: current_year + 1)] : [ann.date]
        dates.each do |d|
          events_data << {
            id:    "ann-#{ann.id}-#{d.year}",
            title: "🎂 #{oshi.name} #{ann.name}",
            start: d.to_s,
            allDay: true,
            color:      oshi.color,
            textColor:  "#ffffff",
            extendedProps: { type: "anniversary", oshi: oshi.name }
          }
        end
      end
    end

    render json: events_data
  end

  private

  def darken(hex)
    return hex unless hex.match?(/\A#[0-9a-fA-F]{6}\z/)
    r = (hex[1..2].to_i(16) * 0.7).to_i
    g = (hex[3..4].to_i(16) * 0.7).to_i
    b = (hex[5..6].to_i(16) * 0.7).to_i
    "#%02x%02x%02x" % [r, g, b]
  end
end

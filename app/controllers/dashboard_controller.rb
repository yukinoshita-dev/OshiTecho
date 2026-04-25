class DashboardController < ApplicationController
  def index
    @oshis = Current.user.oshis.ordered.with_attached_image.limit(6)

    # 今月の集計
    month_start = Date.current.beginning_of_month
    month_end   = Date.current.end_of_month
    month_events = Current.user.events.where(event_date: month_start..month_end)

    @month_event_count = month_events.count
    @month_total_cost  = month_events.sum(:ticket_price)

    # 近日開催（7日以内）
    @upcoming_events = Current.user.events
                               .includes(:oshi)
                               .where(event_date: Date.current..7.days.from_now)
                               .order(:event_date, :start_time)
                               .limit(5)

    # 最近のイベント（過去5件）
    @recent_events = Current.user.events
                             .includes(:oshi)
                             .where("event_date < ?", Date.current)
                             .order(event_date: :desc)
                             .limit(5)

    # 推し別統計
    @oshi_stats = Current.user.oshis.map do |oshi|
      events = Current.user.events.where(oshi: oshi)
      {
        oshi: oshi,
        event_count: events.count,
        total_cost: events.sum(:ticket_price)
      }
    end.sort_by { |s| -s[:event_count] }.first(5)
  end
end

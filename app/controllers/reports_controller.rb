class ReportsController < ApplicationController
  def annual
    @year = (params[:year] || Date.current.year).to_i
    year_range = Date.new(@year, 1, 1)..Date.new(@year, 12, 31)

    events = Current.user.events.where(event_date: year_range)
    goods  = Current.user.goods.where(purchase_date: year_range)

    @total_events      = events.count
    @total_ticket_cost = events.sum(:ticket_price)
    @total_goods_cost  = goods.sum(:price)
    @total_cost        = @total_ticket_cost + @total_goods_cost
    @total_goods_count = goods.count

    # 月別集計
    @monthly_data = (1..12).map do |m|
      month_range = Date.new(@year, m, 1)..Date.new(@year, m, -1)
      month_events = events.where(event_date: month_range)
      {
        month: m,
        event_count: month_events.count,
        ticket_cost: month_events.sum(:ticket_price),
        goods_cost: goods.where(purchase_date: month_range).sum(:price)
      }
    end

    # 推し別統計（イベント数 or グッズ費 > 0 のみ）
    @oshi_stats = Current.user.oshis.map do |oshi|
      oshi_events = events.where(oshi: oshi)
      oshi_goods  = goods.where(oshi: oshi)
      {
        oshi: oshi,
        event_count: oshi_events.count,
        ticket_cost: oshi_events.sum(:ticket_price),
        goods_cost: oshi_goods.sum(:price)
      }
    end.select { |s| s[:event_count] > 0 || s[:goods_cost] > 0 }
       .sort_by { |s| -s[:event_count] }

    # イベント種別内訳
    @event_type_breakdown = events.group(:event_type).count

    # 選択可能な年リスト
    event_years = Current.user.events.pluck(:event_date).map(&:year)
    goods_years = Current.user.goods.pluck(:purchase_date).compact.map(&:year)
    all_years   = (event_years + goods_years).uniq.sort.reverse
    @available_years = all_years.presence || [ Date.current.year ]
  end
end

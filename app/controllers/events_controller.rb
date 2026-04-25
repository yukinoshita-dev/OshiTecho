class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

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

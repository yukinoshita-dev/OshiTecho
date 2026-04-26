class ActivityLogsController < ApplicationController
  before_action :set_log, only: [:show, :edit, :update, :destroy]

  def index
    @oshi_filter   = params[:oshi_id]
    @rating_filter = params[:rating]

    @oshis = Current.user.oshis.ordered
    @logs = Current.user.activity_logs
                   .includes(:oshi, images_attachments: :blob)
                   .by_oshi(@oshi_filter)
                   .by_rating(@rating_filter)
                   .ordered
  end

  def show
  end

  def new
    @log = Current.user.activity_logs.build
    @oshis  = Current.user.oshis.ordered
    @events = Current.user.events.order(event_date: :desc).limit(30)
  end

  def create
    @log = Current.user.activity_logs.build(log_params)
    if @log.save
      redirect_to activity_log_path(@log), notice: "活動ログを保存しました"
    else
      @oshis  = Current.user.oshis.ordered
      @events = Current.user.events.order(event_date: :desc).limit(30)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @oshis  = Current.user.oshis.ordered
    @events = Current.user.events.order(event_date: :desc).limit(30)
  end

  def update
    if @log.update(log_params)
      redirect_to activity_log_path(@log), notice: "活動ログを更新しました"
    else
      @oshis  = Current.user.oshis.ordered
      @events = Current.user.events.order(event_date: :desc).limit(30)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @log.destroy
    redirect_to activity_logs_path, notice: "活動ログを削除しました", status: :see_other
  end

  private

  def set_log
    @log = Current.user.activity_logs.find(params[:id])
  end

  def log_params
    params.require(:activity_log).permit(
      :title, :body, :rating, :visibility,
      :oshi_id, :event_id,
      :transport_cost, :accommodation_cost, :food_cost,
      :companion_note, :setlist,
      images: []
    )
  end
end

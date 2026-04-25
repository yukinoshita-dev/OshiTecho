class OshisController < ApplicationController
  before_action :set_oshi, only: [:show, :edit, :update, :destroy]

  def index
    @oshis = Current.user.oshis.ordered.with_attached_image
  end

  def show
  end

  def new
    @oshi = Current.user.oshis.build
    @oshi.anniversaries.build
  end

  def create
    @oshi = Current.user.oshis.build(oshi_params)
    if @oshi.save
      redirect_to oshis_path, notice: "#{@oshi.name} を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @oshi.anniversaries.build if @oshi.anniversaries.empty?
  end

  def update
    if @oshi.update(oshi_params)
      redirect_to oshis_path, notice: "#{@oshi.name} を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @oshi.destroy
    redirect_to oshis_path, notice: "#{@oshi.name} を削除しました", status: :see_other
  end

  private

  def set_oshi
    @oshi = Current.user.oshis.find(params[:id])
  end

  def oshi_params
    params.require(:oshi).permit(
      :name, :color, :hashtag, :note, :status, :image,
      :twitter_url, :instagram_url, :youtube_url, :tiktok_url,
      anniversaries_attributes: [:id, :name, :date, :yearly, :_destroy]
    )
  end
end

require "csv"

class GoodsController < ApplicationController
  before_action :set_good, only: [:edit, :update, :destroy]

  def index
    @oshi_filter    = params[:oshi_id]
    @category_filter = params[:category]
    @ym_filter      = params[:ym]

    @oshis = Current.user.oshis.ordered
    @goods = Current.user.goods
                    .includes(:oshi, image_attachment: :blob)
                    .by_oshi(@oshi_filter)
                    .by_category(@category_filter)
                    .by_year_month(@ym_filter)
                    .ordered

    @total_price = @goods.sum(:price)

    @monthly_summary = Current.user.goods
                               .where.not(purchase_date: nil)
                               .group_by { |g| g.purchase_date.strftime("%Y-%m") }
                               .transform_values { |gs| gs.sum(&:price) }
                               .sort.reverse.first(12).to_h

    respond_to do |format|
      format.html
      format.csv do
        csv_data = CSV.generate(headers: true) do |csv|
          csv << %w[名前 カテゴリ 推し 購入日 価格（円） メモ]
          @goods.each do |good|
            csv << [
              good.name,
              good.category,
              good.oshi&.name,
              good.purchase_date&.strftime("%Y-%m-%d"),
              good.price,
              good.note
            ]
          end
        end
        send_data "﻿#{csv_data}",
                  filename: "goods_#{Date.current}.csv",
                  type: "text/csv; charset=utf-8",
                  disposition: "attachment"
      end
    end
  end

  def new
    @good = Current.user.goods.build
    @oshis = Current.user.oshis.ordered
  end

  def create
    @good = Current.user.goods.build(good_params)
    if @good.save
      redirect_to goods_path, notice: "#{@good.name} を登録しました"
    else
      @oshis = Current.user.oshis.ordered
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @oshis = Current.user.oshis.ordered
  end

  def update
    if @good.update(good_params)
      redirect_to goods_path, notice: "#{@good.name} を更新しました"
    else
      @oshis = Current.user.oshis.ordered
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @good.destroy
    redirect_to goods_path, notice: "#{@good.name} を削除しました", status: :see_other
  end

  private

  def set_good
    @good = Current.user.goods.find(params[:id])
  end

  def good_params
    params.require(:good).permit(:name, :category, :oshi_id, :purchase_date, :price, :note, :image)
  end
end

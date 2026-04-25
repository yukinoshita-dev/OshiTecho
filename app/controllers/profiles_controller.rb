class ProfilesController < ApplicationController
  allow_unauthenticated_access only: [:show]
  before_action :set_user, only: [:show]

  def show
  end

  def edit
    @user = Current.user
  end

  def update
    @user = Current.user
    if @user.update(profile_params)
      redirect_to edit_profile_path, notice: "プロフィールを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find_by!(username: params[:username])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "ユーザーが見つかりません"
  end

  def profile_params
    params.require(:user).permit(:display_name, :bio, :username, :avatar)
  end
end

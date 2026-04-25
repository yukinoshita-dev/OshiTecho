class UsersController < ApplicationController
  allow_unauthenticated_access only: [:following, :followers]
  before_action :set_user

  def following
    @users = @user.following.includes(:avatar_attachment)
  end

  def followers
    @users = @user.followers.includes(:avatar_attachment)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end

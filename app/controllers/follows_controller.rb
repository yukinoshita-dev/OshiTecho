class FollowsController < ApplicationController
  before_action :set_target_user

  def create
    Current.user.follow(@target_user)
    @target_user.notifications.create!(actor: Current.user, action: "follow")
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: user_profile_path(@target_user.username) }
    end
  end

  def destroy
    Current.user.unfollow(@target_user)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: user_profile_path(@target_user.username) }
    end
  end

  private

  def set_target_user
    @target_user = User.find(params[:user_id])
  end
end

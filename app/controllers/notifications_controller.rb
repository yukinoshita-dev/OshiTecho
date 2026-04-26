class NotificationsController < ApplicationController
  def index
    @notifications = Current.user.notifications.ordered.includes(:actor, :notifiable)
  end

  def mark_all_read
    Current.user.notifications.unread.update_all(read_at: Time.current)
    @notifications = Current.user.notifications.ordered.includes(:actor, :notifiable)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to notifications_path }
    end
  end
end

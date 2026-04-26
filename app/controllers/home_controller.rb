class HomeController < ApplicationController
  allow_unauthenticated_access

  def index
    redirect_to dashboard_path if authenticated?
    @public_events = Event.public_visible
                          .includes(:user, :oshi)
                          .upcoming
                          .limit(10)
  end
end

class ThemesController < ApplicationController
  before_action :require_authentication

  VALID_THEMES = %w[classic girly natural cool].freeze

  def update
    theme = params[:theme]
    return head :unprocessable_entity unless VALID_THEMES.include?(theme)

    Current.user.update!(theme: theme)
    head :ok
  end
end

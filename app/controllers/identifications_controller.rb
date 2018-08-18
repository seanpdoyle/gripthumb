class IdentificationsController < ApplicationController
  def create
    redirect_to songs_url(redirect_params)
  end

  private

  def redirect_params
    params.require(:identification).permit(
      :artist,
      :song,
    )
  end
end

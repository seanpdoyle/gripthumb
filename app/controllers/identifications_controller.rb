class IdentificationsController < ApplicationController
  def create
    redirect_to parts_url(redirect_params)
  end

  private

  def redirect_params
    params.require(:identification).permit(
      :artist,
      :song,
    )
  end
end

class RecordingsController < ApplicationController
  def create
    tui = redirect_params.delete(:tui).presence || -1

    redirect_to song_url(tui, params: redirect_params)
  end

  private

  def redirect_params
    params.require(:recording).permit(
      :artist,
      :name,
      :tui,
    )
  end
end

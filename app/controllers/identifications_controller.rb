class IdentificationsController < ApplicationController
  def create
    song_search = SongSearch.new(song_search_params)

    redirect_to parts_url(parts: song_search.results)
  end

  private

  def song_search_params
    params.require(:identification).permit(
      :artist,
      :title,
    )
  end
end

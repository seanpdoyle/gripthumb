class SongsController < ApplicationController
  def show
    @song = find_song
  end

  private

  def find_song
    if params[:id] == "-1"
      UnknownSong.new
    else
      Song.new(song_params)
    end
  end

  def song_params
    params.permit!.slice(
      :artist,
      :name,
    ).merge(
      cache: Rails.cache,
      tui: params[:id],
    )
  end
end

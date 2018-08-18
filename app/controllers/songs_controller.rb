class SongsController < ApplicationController
  def index
    @parts = fetch_parts
  end

  private

  def song_search_params
    params.permit!.slice(
      :artist,
      :song,
    )
  end

  def song_search
    SongSearch.new(song_search_params.merge(cache: Rails.cache))
  end

  def fetch_parts
    song_search.results.map do |part|
      attributes = part.fetch(:part).values_at(
        :video,
        :name,
      )

      Part.new(*attributes)
    end
  end
end

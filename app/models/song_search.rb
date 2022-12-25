class SongSearch < ApplicationModel
  Result = Data.define(:video, :part)

  attribute :cache, default: {}
  attribute :song

  def results
    cache.fetch(search_url) do
      response = JSON.parse(URI.parse(search_url).read, symbolize_names: true)

      response.fetch(:song_results, []).flat_map do |search_result|
        video = search_result.fetch(:title)

        search_result.fetch(:soundtracks, []).map do |soundtrack|
          Result.new(video, soundtrack.fetch(:section))
        end
      end
    end
  end

  private

  def search_text
    [song.artist, song.name].join(" ").squish.downcase.gsub(/[^[:word:]\s]/i, "")
  end

  def search_url
    "https://skatevideosite.com/api/search?" + {search_text:}.to_query
  end
end

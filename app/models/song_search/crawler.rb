class SongSearch
  class Crawler
    Result = Struct.new(:video, :part)

    def initialize(song)
      @song = song
    end

    def results
      raw_json = URI.parse(search_url(search_text: term)).open.read
      response = JSON.parse(raw_json, symbolize_names: true)

      response.fetch(:song_results, []).flat_map do |search_result|
        video = search_result.fetch(:title)

        search_result.fetch(:soundtracks, []).map do |soundtrack|
          Result.new(video, soundtrack.fetch(:section))
        end
      end
    end

    private

    def term
      [@song.artist, @song.name].join(" ").squish.downcase.gsub(/[^[:word:]\s]/i, "")
    end

    def search_url(params)
      "https://skatevideosite.com/api/search?" + params.to_query
    end
  end
end

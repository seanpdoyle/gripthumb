class SongSearch
  class Request
    def initialize(song, cache: {})
      @cache = cache
      @song = song
    end

    def response
      cache.fetch("songsearch/#{search_term}") do
        Net::HTTP.post(uri, data.to_query)
      end
    end

    private

    attr_reader :cache, :song

    def search_term
      [
        song.artist,
        song.name
      ].map(&:downcase).join(" ")
    end

    def data
      {
        page: "songsearch",
        select: "2",
        searchterm: search_term
      }
    end

    def uri
      URI.parse("http://www.skatevideosite.com/songsearch")
    end
  end
end

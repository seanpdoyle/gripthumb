class SongSearch
  class Request
    def initialize(song_search, cache: {})
      @cache = cache
      @song_search = song_search
    end

    def response
      cache.fetch("songsearch/#{search_term}") do
        Net::HTTP.post(uri, data.to_query)
      end
    end

    private

    attr_reader :cache, :song_search

    def search_term
      [
        song_search.artist,
        song_search.song,
      ].map(&:downcase).join(" ")
    end

    def data
      {
        page: "songsearch",
        select: "2",
        searchterm: search_term,
      }
    end

    def uri
      URI.parse("http://www.skatevideosite.com/songsearch")
    end
  end
end

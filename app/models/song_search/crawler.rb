class SongSearch
  class Crawler
    Result = Struct.new(:video, :part)

    def initialize(song)
      @song = song
    end

    def results
      root = Capybara::Session.new(:mechanize) { |config| config.app_host = "https://skatevideosite.com/" }
      root.visit root_url(s: term)

      results = Concurrent::Array.new
      threads = root.all("#main [itemscope] [itemprop=headline] a").map { |link|
        video = link.text.squish

        Thread.new {
          session = Capybara::Session.new(:mechanize) { |config| config.app_host = "https://skatevideosite.com/" }
          session.visit link[:href]

          matches = session.find("#soundtrack p").native.inner_html.split("<br>")
            .map { |html| Capybara.string(html) }
            .map { |row| row.text.split("–").map(&:squish) }
            .each_with_index
            .select { |row| row.join(" ").to_s.downcase.gsub(/[^[:word:]\s]/i, "").include?(term) }
            .map { |part, index|
              if part.many?
                Result.new(video, part.first)
              else
                one_based = index + 1

                Result.new(video, "#{[one_based, one_based.ordinal].join} song")
              end
            }

          results.concat matches
        }
      }

      threads.each(&:join)

      results
    end

    private

    def term
      [@song.artist, @song.name].join(" ").squish.downcase.gsub(/[^[:word:]\s]/i, "")
    end

    def root_url(params)
      "/?" + params.to_query
    end
  end
end

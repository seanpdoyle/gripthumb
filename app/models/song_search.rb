class SongSearch < ApplicationModel
  attribute :cache, default: {}
  attribute :song

  def results
    SongSearch::Crawler.new(song).results
  end
end

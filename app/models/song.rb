class Song < ApplicationModel
  PARENTHESIZED_PHRASES = /(\[|\().*(\]|\))/

  attribute :artist, :string
  attribute :name, :string
  attribute :cache, default: {}
  attribute :tui, :integer

  def parts
    search.results.map { |result| Part.new video: result.video, name: result.part }
  end

  def name
    super
      .gsub(PARENTHESIZED_PHRASES, "")
      .squish
      .strip
  end

  private

  def search
    SongSearch.new(song: self, cache: cache)
  end
end

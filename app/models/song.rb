class Song
  include ActiveModel::Model
  include ActiveModel::Attributes

  PARENTHESIZED_PHRASES = /(\[|\().*(\]|\))/

  attribute :artist, :string
  attribute :name, :string
  attribute :cache, default: {}
  attribute :tui, :integer

  def parts
    search.results.map do |part|
      attributes = part.fetch(:part).values_at(
        :video,
        :name
      )

      Part.new(*attributes)
    end
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

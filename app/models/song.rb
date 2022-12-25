class Song < ApplicationModel
  PARENTHESIZED_PHRASES = /(\[|\().*(\]|\))/

  attribute :artist, :string
  attribute :name, :string
  attribute :cache, default: {}

  def parts
    Parts::Search.new(song: self, cache:).results
  end

  def name
    super
      .gsub(PARENTHESIZED_PHRASES, "")
      .squish
      .strip
  end
end

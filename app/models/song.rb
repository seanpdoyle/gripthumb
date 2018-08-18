class Song
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :artist, :string
  attribute :name, :string
  attribute :cache, default: {}
  attribute :tui, :integer

  def parts
    search.results.map do |part|
      attributes = part.fetch(:part).values_at(
        :video,
        :name,
      )

      Part.new(*attributes)
    end
  end

  private

  def search
    SongSearch.new(song: self, cache: cache)
  end
end

class SongSearch
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :cache, default: {}
  attribute :artist, :string
  attribute :song, :string

  def results
    request = Request.new(self, cache: cache)
    response_html = Nokogiri::HTML(request.response.body)
    document = Document.new(response_html)

    document.parts
  end
end

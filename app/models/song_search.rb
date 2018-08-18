class SongSearch
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :cache, default: {}
  attribute :song

  def results
    request = Request.new(song, cache: cache)
    response_html = Nokogiri::HTML(request.response.body)
    document = Document.new(response_html)

    document.parts
  end
end

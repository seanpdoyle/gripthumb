class SongSearch
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :artist, :string
  attribute :title, :string

  def results
    uri = URI.parse("http://www.skatevideosite.com/songsearch")
    form_data = {
      page: "songsearch",
      select: "2",
      searchterm: [artist.downcase, title.downcase].join(" "),
    }
    response = Net::HTTP.post(uri, form_data.to_query)
    document = Nokogiri::HTML(response.body)

    elements = document.css(".skatevideolist tr")

    elements.each_slice(2).flat_map do |video_element, songs_element|
      video_title, * = video_element.css("td .videotitle")

      songs_element.css("td").map do |songs_split_by_br|
        name, * = songs_split_by_br.children.select(&:text?)

        {
          part: {
            video: video_title.text.squish,
            name: name.text.gsub("-", "").squish,
          },
        }
      end
    end
  end
end

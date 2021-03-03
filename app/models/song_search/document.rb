class SongSearch
  class Document
    def initialize(html)
      @html = html
    end

    def parts
      elements_in_pairs.flat_map do |video_element, songs_element|
        video_title, * = video_element.css("td .videotitle")

        songs_element.css("td").map do |songs_split_by_br|
          name, * = songs_split_by_br.children.select(&:text?)

          {
            part: {
              video: video_title.text.squish,
              name: name.text.delete("-").squish
            }
          }
        end
      end
    end

    private

    def elements_in_pairs
      elements.each_slice(2)
    end

    def elements
      @html.css(".skatevideolist tr")
    end
  end
end

module MockedSongSearch
  MockResult = Struct.new(:artist, :song, :video, :part)

  def self.included(base)
    base.setup do
      fixture_root = Pathname.new(fixture_path).join("files")
      response_html = fixture_root.join("songsearch.html").read
      empty_html = fixture_root.join("songsearch-empty.html").read
      form_data = {
        page: "songsearch",
        select: "2",
        searchterm: [
          mocked_result.artist,
          mocked_result.song,
        ].map(&:downcase).join(" "),
      }

      stubbed_post = stub_request(
        :post,
        "http://www.skatevideosite.com/songsearch",
      )

      stubbed_post.
        with(body: form_data.to_query).
        to_return(body: response_html)
      stubbed_post.
        to_return(body: empty_html)
    end
  end

  def mocked_result
    MockResult.new(
      "Duster",
      "Echo, Bravo",
      "The 917 Video",
      "Aaron Loreth",
    )
  end
end

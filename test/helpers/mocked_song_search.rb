module MockedSongSearch
  MockResult = Struct.new(:artist, :song, :video, :part)

  def self.included(base)
    base.setup do
      response_html = Pathname(fixture_path).join("files", "songsearch.html").read
      form_data = {
        page: "songsearch",
        select: "2",
        searchterm: [
          mocked_result.artist,
          mocked_result.song,
        ].map(&:downcase).join(" ")
      }

      stub_request(:post, "http://www.skatevideosite.com/songsearch").
        with(body: form_data.to_query).to_return(body: response_html)
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

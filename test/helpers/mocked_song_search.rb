module MockedSongSearch
  MockResult = Struct.new(:song, :video, :part)

  def self.included(base)
    base.setup do
      response_html = response_fixture_path.join("songsearch.html").read
      form_data = {
        page: "songsearch",
        select: "2",
        searchterm: [
          mocked_result.song.artist,
          mocked_result.song.name,
        ].map(&:downcase).join(" "),
      }
      stub_song_search(form_data.to_query, response: response_html)
    end
  end

  def response_fixture_path
    Pathname.new(fixture_path).join("files")
  end

  def empty_html
    response_fixture_path.join("songsearch-empty.html").read
  end

  def stub_song_search(body, response: empty_html)
    stub_request(
      :post,
      "http://www.skatevideosite.com/songsearch",
    ).with(body: body).to_return(body: response)
  end

  def mocked_result
    MockResult.new(
      Song.new(artist: "Duster", name: "Echo, Bravo", tui: 8420973),
      "The 917 Video",
      "Aaron Loreth",
    )
  end
end

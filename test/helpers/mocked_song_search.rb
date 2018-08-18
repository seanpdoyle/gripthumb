module MockedSongSearch
  MockResult = Struct.new(:song, :video, :part)

  def response_fixture_path
    Pathname.new(fixture_path).join("files")
  end

  def stub_song_search(body, html: :empty)
    case body
    when Array
      form_data = {
        page: "songsearch",
        select: "2",
        searchterm: body.map(&:downcase).join(" "),
      }.to_query
    when Regexp
      form_data = body
    end

    response_html = response_fixture_path.join("songsearch", "#{html}.html")

    stub_request(:post, "http://www.skatevideosite.com/songsearch").
      with(body: form_data).
      to_return(body: response_html.read)
  end

  def stub_song_search_with_mock
    song = mocked_result.song

    stub_song_search([song.artist, song.name], html: :duster)
  end

  def mocked_result
    MockResult.new(
      Song.new(artist: "Duster", name: "Echo, Bravo", tui: 8420973),
      "The 917 Video",
      "Aaron Loreth",
    )
  end
end

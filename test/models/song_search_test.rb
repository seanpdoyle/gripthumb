require "test_helper"

class SongSearchTest < ActiveSupport::TestCase
  test "results are scraped from SkateVideoSite" do
    response_html = Pathname(fixture_path).join("files", "songsearch.html")
    stub_request(:post, "http://www.skatevideosite.com/songsearch").
      with(
        body: {
          page: "songsearch",
          select: "2",
          searchterm: "duster echo, bravo",
        }.to_query,
      ).to_return(body: File.new(response_html))
    song_search = SongSearch.new(artist: "Duster", title: "Echo, Bravo")

    results = song_search.results

    assert_equal results, [
      { part: { video: "The 917 Video", name: "Aaron Loreth" } },
    ]
  end
end

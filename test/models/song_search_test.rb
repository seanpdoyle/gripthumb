require "test_helper"

class SongSearchTest < ActiveSupport::TestCase
  test "results are scraped from SkateVideoSite" do
    song_search = SongSearch.new(artist: "Duster", title: "Echo, Bravo")

    results = song_search.results

    assert_equal results, [
      { part: { video: "The 917 Video", name: "Aaron Loreth" } },
    ]
  end
end

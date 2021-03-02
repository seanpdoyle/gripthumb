require "test_helper"

class SongSearchTest < ActiveSupport::TestCase
  include VcrTestHelper

  test "results are scraped from SkateVideoSite" do
    song = Song.new artist: "Duster", name: "Echo, Bravo"
    search = SongSearch.new song: song

    result = search.results.first

    assert_equal "The 917 Video", result.video
    assert_equal "Aaron Loreth", result.part
  end

  test "results strip qualifiers" do
    song = Song.new artist: "New Order", name: "Cries and Whispers [12\" Version Remastered]"
    search = SongSearch.new song: song

    result = search.results.first

    assert_equal "Converse – Purple", result.video
    assert_equal "Brian Delatorre and Al Davis", result.part
  end

  test "returns an empty list when there are no results" do
    song = Song.new artist: "junk", name: "song nobody skated to"
    search = SongSearch.new song: song

    results = search.results

    assert_empty results
  end
end

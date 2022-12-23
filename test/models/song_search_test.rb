require "test_helper"

class SongSearchTest < ActiveSupport::TestCase
  include VcrTestHelper

  test "results in the format of ($PART - $SONG) are scraped from SkateVideoSite" do
    song = Song.new artist: "Duster", name: "Echo, Bravo"
    search = SongSearch.new song: song

    result = search.results.first

    assert_equal "Call Me (917) - The (917) Video", result.video
    assert_equal "Aaron Loreth", result.part
  end

  test "results in the format of ($PART - $ARTIST - $SONG) are scraped from SkateVideoSite" do
    song = Song.new artist: "Type O Negative", name: "Drunk in Paris"
    search = SongSearch.new song: song

    result = search.results.first

    assert_equal "FA World Entertainment - Dancing On Thin Ice", result.video
    assert_equal "Kevin Rodrigues", result.part
  end

  test "results in the format of ($SONG) are scraped from SkateVideoSite" do
    song = Song.new artist: "Creedence Clearwater Revival", name: "Effigy"
    search = SongSearch.new song: song

    result = search.results.first

    assert_equal "Sure", result.video
    assert_equal "2", result.part
  end

  test "results strip qualifiers" do
    song = Song.new artist: "New Order", name: "Cries and Whispers [12\" Version Remastered]"
    search = SongSearch.new song: song

    result = search.results.first

    assert_equal "Converse - Purple", result.video
    assert_equal "Brian Delatorre and Al Davis", result.part
  end

  test "returns an empty list when there are no results" do
    song = Song.new artist: "junk", name: "song nobody skated to"
    search = SongSearch.new song: song

    results = search.results

    assert_empty results
  end
end

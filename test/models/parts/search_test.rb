require "test_helper"
require "test_helpers/vcr_test_helper"

class Parts::SearchTest < ActiveSupport::TestCase
  include VcrTestHelper

  test "results in the format of ($PART - $SONG) are scraped from SkateVideoSite" do
    song = Song.new artist: "Duster", name: "Echo, Bravo"
    search = Parts::Search.new song: song

    result = search.results.first

    assert_equal "Call Me (917) - The (917) Video", result.video
    assert_equal "Aaron Loreth", result.name
  end

  test "results in the format of ($PART - $ARTIST - $SONG) are scraped from SkateVideoSite" do
    song = Song.new artist: "Type O Negative", name: "Drunk in Paris"
    search = Parts::Search.new song: song

    result = search.results.first

    assert_equal "FA World Entertainment - Dancing On Thin Ice", result.video
    assert_equal "Kevin Rodrigues", result.name
  end

  test "results in the format of ($SONG) are scraped from SkateVideoSite" do
    song = Song.new artist: "Creedence Clearwater Revival", name: "Effigy"
    search = Parts::Search.new song: song

    result = search.results.first

    assert_equal "Sure", result.video
    assert_equal "2", result.name
  end

  test "results strip qualifiers" do
    song = Song.new artist: "New Order", name: "Cries and Whispers [12\" Version Remastered]"
    search = Parts::Search.new song: song

    result = search.results.first

    assert_equal "Converse - Purple", result.video
    assert_equal "Brian Delatorre and Al Davis", result.name
  end

  test "returns an empty list when there are no results" do
    song = Song.new artist: "junk", name: "song nobody skated to"
    search = Parts::Search.new song: song

    results = search.results

    assert_empty results
  end
end

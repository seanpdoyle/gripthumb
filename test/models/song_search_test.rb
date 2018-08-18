require "test_helper"
require_relative "../helpers/mocked_song_search"

class SongSearchTest < ActiveSupport::TestCase
  include MockedSongSearch

  test "results are scraped from SkateVideoSite" do
    song_search = SongSearch.new(
      song: mocked_result.song,
    )

    results = song_search.results

    assert_equal results, [
      { part: { video: mocked_result.video, name: mocked_result.part } },
    ]
  end
end

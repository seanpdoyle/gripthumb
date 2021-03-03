require "test_helper"
require_relative "../helpers/mocked_song_search"

class SongSearchTest < ActiveSupport::TestCase
  include MockedSongSearch

  test "results are scraped from SkateVideoSite" do
    stub_song_search_with_mock
    song_search = SongSearch.new(
      song: mocked_result.song
    )

    results = song_search.results

    assert_equal results, [
      {part: {video: mocked_result.video, name: mocked_result.part}}
    ]
  end

  test "results strip qualifiers" do
    song = Song.new(
      artist: "New Order",
      name: "Cries and Whispers [12\" Version Remastered]"
    )
    stub_song_search([song.artist, "cries and whispers"], html: :qualifiers)
    song_search = SongSearch.new(song: song)

    results = song_search.results

    assert_equal results, [{
      part: {
        video: "Converse - Purple",
        name: "Brian Delatorre and Al Davis"
      }
    }]
  end
end

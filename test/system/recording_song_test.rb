require "test_helper"
require_relative "../rack_system_test_case"
require_relative "../helpers/mocked_song_search"

class RecordingSongTestCase < RackSystemTestCase
  include MockedSongSearch

  test "Looks up the Skate Video soundtrack for a song" do
    stub_song_search_with_mock

    visit root_path
    fill_in label(:recording, :tui), with: mocked_result.song.tui
    fill_in label(:recording, :artist), with: mocked_result.song.artist
    fill_in label(:recording, :name), with: mocked_result.song.name
    click_on submit(:recording)

    assert page.has_text?(mocked_result.video)
    assert page.has_text?(mocked_result.part)
  end

  test "Shows an empty list when there are no results" do
    stub_song_search(/the\+artist/, html: :empty)

    visit root_path
    fill_in label(:recording, :artist), with: "The Artist"
    fill_in label(:recording, :name), with: "Nobody Skated to this"
    fill_in label(:recording, :tui), with: "abc123"
    click_on submit(:recording)

    assert page.has_text?(translate("songs.empty.text"))
  end

  test "Shows an error message when the song can't be identified" do
    stub_song_search(//, html: :empty)

    visit root_path
    fill_in label(:recording, :artist), with: ""
    fill_in label(:recording, :name), with: ""
    fill_in label(:recording, :tui), with: ""
    click_on submit(:recording)

    assert page.has_text?(translate("unknown_songs.unknown_song.title"))
  end

  def submit(key, action = :create)
    translate(action, scope: [:helpers, :submit, key])
  end

  def label(*keys)
    key = keys.pop

    translate(key, scope: [:helpers, :label] + keys)
  end
end

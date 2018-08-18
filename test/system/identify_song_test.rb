require "test_helper"
require_relative "../rack_system_test_case"
require_relative "../helpers/mocked_song_search"

class IdentifySongTestCase < RackSystemTestCase
  include MockedSongSearch

  test "Looks up the Skate Video soundtrack for a song" do
    visit root_path
    fill_in label(:identification, :tui), with: mocked_result.song.tui
    fill_in label(:identification, :artist), with: mocked_result.song.artist
    fill_in label(:identification, :name), with: mocked_result.song.name
    click_on submit(:identification)

    assert page.has_text?(mocked_result.video)
    assert page.has_text?(mocked_result.part)
  end

  test "Shows an empty list when there are no results" do
    stub_song_search(/the\+artist/)

    visit root_path
    fill_in label(:identification, :artist), with: "The Artist"
    fill_in label(:identification, :name), with: "Nobody Skated to this"
    fill_in label(:identification, :tui), with: "abc123"
    click_on submit(:identification)

    assert page.has_text?(translate("songs.empty.text"))
  end

  test "Shows an error message when the song can't be identified" do
    stub_song_search(//)

    visit root_path
    fill_in label(:identification, :artist), with: ""
    fill_in label(:identification, :name), with: ""
    fill_in label(:identification, :tui), with: ""
    click_on submit(:identification)

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

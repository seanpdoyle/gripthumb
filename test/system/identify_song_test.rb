require "test_helper"
require_relative "../rack_system_test_case"
require_relative "../helpers/mocked_song_search"

class IdentifySongTestCase < RackSystemTestCase
  include MockedSongSearch

  test "Looks up the Skate Video soundtrack for a song" do
    visit root_path
    fill_in label(:identification, :artist), with: mocked_result.artist
    fill_in label(:identification, :song), with: mocked_result.song
    click_on submit(:identification)

    assert page.has_text?(mocked_result.video)
    assert page.has_text?(mocked_result.part)
  end

  test "Shows an empty list when there are no results" do
    visit root_path
    fill_in label(:identification, :artist), with: "Not an Artist"
    fill_in label(:identification, :song), with: "Not a Song"
    click_on submit(:identification)

    assert page.has_text?(translate("parts.empty.text"))
  end

  def submit(key, action = :create)
    translate(action, scope: [:helpers, :submit, key])
  end

  def label(*keys)
    key = keys.pop

    translate(key, scope: [:helpers, :label] + keys)
  end
end

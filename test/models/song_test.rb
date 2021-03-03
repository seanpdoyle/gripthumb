require_relative "../test_helper"

class SongTestCase < ActiveSupport::TestCase
  test "sanitizes name" do
    song = Song.new(
      name: "Cries and \nWhispers [12\" Version Remastered]"
    )

    name = song.name

    assert_equal name, "Cries and Whispers"
  end
end

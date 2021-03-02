require "application_system_test_case"

class RecordingSongTestCase < ApplicationSystemTestCase
  include VcrTestHelper

  test "Looks up the Skate Video soundtrack for a song" do
    visit root_path
    attach_file "File", file_fixture("in-dreams.m4a")
    click_on "Submit"

    assert_text "In Dreams"
    assert_text "Roy Orbison"
    assert_text "Isle – Vase"
    assert_text "Credits"
    assert_text "Enjoi – Oververt"
    assert_text "Nestor Judkins"
  end

  test "Gracefully handles unrecognizable songs" do
    visit root_path
    attach_file "File", file_fixture("silence.m4a")
    click_on "Submit"

    assert_button "Recognize song"
  end

  test "Gracefully handles Audd errors" do
    visit root_path
    click_on "Submit"

    assert_button "Recognize song"
  end
end

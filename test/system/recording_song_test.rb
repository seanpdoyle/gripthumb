require "application_system_test_case"
require "test_helpers/vcr_test_helper"

class RecordingSongTestCase < ApplicationSystemTestCase
  include VcrTestHelper

  test "Looks up the Skate Video soundtrack for a song" do
    visit root_path
    attach_file "File", file_fixture("in-dreams.m4a")

    assert_no_text "Try again"
    click_on "Submit"
    assert_no_text "Try again"

    assert_text "In Dreams"
    assert_text "Roy Orbison"
    assert_text "Isle - Vase"
    assert_text "Credits"
    assert_text "Enjoi - Oververt"
    assert_text "Nestor Judkins"
  end

  test "hides error message when songs are found" do
    visit root_path

    attach_file "File", file_fixture("silence.m4a")
    assert_no_text "Try again"
    click_on "Submit"
    assert_text "Try again"

    attach_file "File", file_fixture("in-dreams.m4a")
    click_on "Submit"

    assert_no_text "Try again"
    assert_text "In Dreams"
    assert_text "Roy Orbison"
  end

  test "Gracefully handles unrecognizable songs" do
    visit root_path
    attach_file "File", file_fixture("silence.m4a")

    assert_no_text "Try again"
    click_on "Submit"
    assert_text "Try again"
  end

  test "Gracefully handles Audd errors" do
    visit root_path

    assert_no_text "Try again"
    click_on "Submit"
    assert_text "Try again"
  end
end

require "test_helper"
require_relative "../rack_system_test_case"

class IdentifySongTestCase < RackSystemTestCase
  test "Looks up the Skate Video soundtrack for a song" do
    response_html = Pathname(fixture_path).join("files", "songsearch.html")
    stub_request(:post, "http://www.skatevideosite.com/songsearch").
      with(
        body: {
          page: "songsearch",
          select: "2",
          searchterm: "duster echo, bravo",
        }.to_query,
      ).to_return(body: File.new(response_html))

    visit root_path
    fill_in label(:identification, :artist), with: "Duster"
    fill_in label(:identification, :song), with: "Echo, Bravo"
    click_on submit(:identification)

    assert page.has_text?("The 917 Video")
    assert page.has_text?("Aaron Loreth")
  end

  def submit(key, action = :create)
    translate(action, scope: [:helpers, :submit, key])
  end

  def label(*keys)
    key = keys.pop

    translate(key, scope: [:helpers, :label] + keys)
  end
end

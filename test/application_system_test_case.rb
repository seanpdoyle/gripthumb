require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include AbstractController::Translation

  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]

  def self.debug!
    driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
  end
end

Capybara.configure do |config|
  config.server = :puma, {Silent: true}
  config.default_normalize_ws = true
  config.default_max_wait_time = 3
end

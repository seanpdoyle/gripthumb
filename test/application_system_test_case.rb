require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include AbstractController::Translation

  driven_by :cuprite, using: :chrome, options: {js_errors: true}

  def self.debug!
    driven_by :cuprite, using: :chrome, options: {headless: false}
  end
end

Capybara.configure do |config|
  config.server = :puma, {Silent: true}
  config.default_normalize_ws = true
  config.default_max_wait_time = 3
end

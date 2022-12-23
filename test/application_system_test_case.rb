require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include AbstractController::Translation

  driven_by :cuprite, using: :chrome

  def self.debug!
    driven_by :selenium, using: :chrome
  end
end

Capybara.register_driver :cuprite do |app|
  Capybara::Cuprite::Driver.new(app, window_size: [1200, 800])
end

Capybara.configure do |config|
  config.javascript_driver = :cuprite
  config.server = :puma, {Silent: true}
  config.default_normalize_ws = true
  config.default_max_wait_time = 3
end

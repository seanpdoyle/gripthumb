ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "webmock/minitest"

VCR.configure do |config|
  config.ignore_localhost = true
  config.allow_http_connections_when_no_cassette = true
  config.cassette_library_dir = Rails.root.join "test", "vcr_cassettes"
  config.hook_into :webmock
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

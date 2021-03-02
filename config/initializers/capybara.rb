require "capybara"

Capybara.threadsafe = true

Capybara.register_driver :mechanize do
  Capybara::Mechanize::Driver.new(proc {})
end

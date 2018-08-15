require_relative "./application_system_test_case"

class RackSystemTestCase < ApplicationSystemTestCase
  driven_by :rack_test
end

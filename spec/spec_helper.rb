# frozen_string_literal: true

require "interest_days"
require "date"
require "pry"
require "simplecov"
SimpleCov.start do
  add_group "Libraries", "lib/"
  add_group "Calculations", "lib/calculation"
  track_files "{lib}/**/*.rb"
end

# require "codecov"
# SimpleCov.formatter = SimpleCov::Formatter::Codecov

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

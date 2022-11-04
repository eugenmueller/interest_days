# frozen_string_literal: true

# Coverage by SimpleCov/CodeCov
if ENV["CODECOV"]
  require "codecov" # require also simplecov
  # if you want the formatter to upload the results use SimpleCov::Formatter::Codecov instead
  SimpleCov.formatter = Codecov::SimpleCov::Formatter # upload with step in github actions
elsif !ENV["CI"]   # exclude in CI
  require "simplecov"
  SimpleCov.configure do
    add_filter "spec"
    command_name "Task##{$PROCESS_ID}"
    merge_timeout 20
    enable_coverage :branch
    add_group "Integration", %w[/lib/interest_days.rb /lib/interest_days/calculator.rb /lib/interest_days/version.rb]
    add_group "Calculation", "lib/interest_days/calculation"
    track_files "{lib}/**/*.rb"
  end
  SimpleCov.formatter = SimpleCov::Formatter::SimpleFormatter unless ENV["HTML_REPORTS"] == "true"
  SimpleCov.start
end

# frozen_string_literal: true

require_relative "lib/interest_days/version"

Gem::Specification.new do |spec|
  spec.name          = "interest_days"
  spec.version       = InterestDays::VERSION
  spec.authors       = ["Eugen Mueller", "Kevin Liebholz", "Cassy Dodd"]
  spec.email         = ["eugen.mllr@gmail.com"]

  spec.summary       = "Interest day calculation"
  spec.description   = "Interest days gem calculate interest days depends on desired method."
  spec.homepage      = "https://github.com/eugenmueller/interest_days"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'https://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/eugenmueller/interest_days"
  spec.metadata["changelog_uri"] = "https://github.com/eugenmueller/interest_days/blob/v0.2.0/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  # spec.files = Dir.chdir(File.expand_path(__dir__)) do
  #   `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  # end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_development_dependency "pry", "~> 0.13.1"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "rubocop-rake"
  spec.add_development_dependency "rubocop-rspec"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata["rubygems_mfa_required"] = "true"
end

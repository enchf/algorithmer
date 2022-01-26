# frozen_string_literal: true

require_relative "lib/problems/version"

Gem::Specification.new do |spec|
  spec.name          = "problems"
  spec.version       = Problems::VERSION
  spec.authors       = ["enchf"]

  spec.summary       = "CLI to manage and run programming challanges and their test cases."
  spec.description   = "CLI that provides a way to add problems, solutions, test cases and its executions."
  spec.homepage      = "https://github.com/enchf/problems"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.5.5")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Development & Testing dependencies.
  spec.add_development_dependency 'artii', '~> 2.1', '>= 2.1.2'
  spec.add_development_dependency 'byebug', '~> 9.0'
  spec.add_development_dependency 'colored', '~> 1.2'
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency 'minitest-reporters', '~> 1.4'
  spec.add_development_dependency 'mocha', '~> 1.13'
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rubocop", "~> 0.80"
  spec.add_development_dependency 'terminal-table', '~> 3.0'

  # Runtime dependencies.
  spec.add_dependency "toolcase", "~> 0.4.0"
end

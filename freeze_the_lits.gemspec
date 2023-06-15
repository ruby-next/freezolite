# frozen_string_literal: true

require_relative "lib/freeze_the_lits/version"

Gem::Specification.new do |s|
  s.name = "freeze_the_lits"
  s.version = FreezeTheLits::VERSION
  s.authors = ["Vladimir Dementyev"]
  s.email = ["Vladimir Dementyev"]
  s.homepage = "https://github.com/ruby-next/freeze_the_lits"
  s.summary = "Example description"
  s.description = "Example description"

  s.metadata = {
    "bug_tracker_uri" => "https://github.com/ruby-next/freeze_the_lits/issues",
    "changelog_uri" => "https://github.com/ruby-next/freeze_the_lits/blob/master/CHANGELOG.md",
    "documentation_uri" => "https://github.com/ruby-next/freeze_the_lits",
    "homepage_uri" => "https://github.com/ruby-next/freeze_the_lits",
    "source_code_uri" => "https://github.com/ruby-next/freeze_the_lits"
  }

  s.license = "MIT"

  s.files = Dir.glob("lib/**/*") + Dir.glob("bin/**/*") + %w[README.md LICENSE.txt CHANGELOG.md]
  s.require_paths = ["lib"]
  s.required_ruby_version = ">= 2.7"

  s.add_development_dependency "bundler", ">= 1.15"
  s.add_development_dependency "rake", ">= 13.0"
  s.add_development_dependency "minitest", "~> 5.0"
end

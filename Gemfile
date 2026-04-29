# frozen_string_literal: true

source "https://rubygems.org"

gem "debug", platform: :mri

gemspec

eval_gemfile "gemfiles/rubocop.gemfile"

if File.directory?("../require-hooks")
  gem "require-hooks", path: "../require-hooks"
end

local_gemfile = "#{File.dirname(__FILE__)}/Gemfile.local"

if File.exist?(local_gemfile)
  eval(File.read(local_gemfile)) # rubocop:disable Security/Eval
end

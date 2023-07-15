# frozen_string_literal: true

begin
  require "debug" unless ENV["CI"]
rescue LoadError
end

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "freezolite"

if ENV["FREEZOLITE_DISABLED"] == "true"
  $stdout.puts "Freezolite is disabled"
else
  Freezolite.setup(
    watch_dirs: [
      File.join(__dir__, "fixtures", "app"),
      File.join(__dir__, "fixtures", "test")
    ]
  )
end

Dir["#{__dir__}/support/**/*.rb"].sort.each { |f| require f }

require "minitest/autorun"

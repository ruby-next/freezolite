# frozen_string_literal: true

begin
  require "debug" unless ENV["CI"]
rescue LoadError
end

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "freeze_the_lits"

if ENV["FREEZE_THE_LITS"] == "false"
  $stdout.puts "FREEZE_THE_LITS is disabled"
else
  FreezeTheLits.setup(
    watch_dirs: [
      File.join(__dir__, "fixtures", "app"),
      File.join(__dir__, "fixtures", "test")
    ]
  )
end

Dir["#{__dir__}/support/**/*.rb"].sort.each { |f| require f }

require "minitest/autorun"

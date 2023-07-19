require "freezolite"

Freezolite.setup(
  patterns: [File.join(Dir.pwd, "*.rb")],
  exclude_patterns: [File.join(Dir.pwd, "vendor", "*")]
)

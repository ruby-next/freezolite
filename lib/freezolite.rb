# frozen_string_literal: true

require "freezolite/version"

module Freezolite
  class << self
    attr_accessor :patterns, :exclude_patterns

    def setup(patterns:, exclude_patterns: nil)
      self.patterns = patterns
      self.exclude_patterns = exclude_patterns

      require "require-hooks/setup"

      ::RequireHooks.around_load do |path, &block|
        next block.call unless patterns.any? { |pattern| File.fnmatch?(pattern, path) }
        next block.call if exclude_patterns&.any? { |pattern| File.fnmatch?(pattern, path) }

        begin
          was_frozen_string_literal = ::RubyVM::InstructionSequence.compile_option[:frozen_string_literal]
          ::RubyVM::InstructionSequence.compile_option = {frozen_string_literal: true}
          block.call
        ensure
          ::RubyVM::InstructionSequence.compile_option = {frozen_string_literal: was_frozen_string_literal}
        end
      end
    end
  end
end

# frozen_string_literal: true

require "freezolite/version"

module Freezolite
  class << self
    def setup(patterns:, exclude_patterns: nil)
      require "require-hooks/setup"

      ::RequireHooks.around_load(patterns: patterns, exclude_patterns: exclude_patterns) do |path, &block|
        was_frozen_string_literal = ::RubyVM::InstructionSequence.compile_option[:frozen_string_literal]
        ::RubyVM::InstructionSequence.compile_option = {frozen_string_literal: true}
        block.call
      ensure
        ::RubyVM::InstructionSequence.compile_option = {frozen_string_literal: was_frozen_string_literal}
      end
    end
  end
end

# frozen_string_literal: true

require "freezolite/version"

module Freezolite
  class << self
    attr_reader :experimental_freeze_constants

    def experimental_freeze_constants=(val)
      @experimental_freeze_constants = (val == true) ? :literal : val
    end

    def setup(patterns:, exclude_patterns: nil)
      require "require-hooks/setup"

      ::RequireHooks.around_load(patterns: patterns, exclude_patterns: exclude_patterns) do |path, &block|
        was_frozen_string_literal = ::RubyVM::InstructionSequence.compile_option[:frozen_string_literal] || false
        ::RubyVM::InstructionSequence.compile_option = {frozen_string_literal: true}
        block.call
      ensure
        ::RubyVM::InstructionSequence.compile_option = {frozen_string_literal: was_frozen_string_literal}
      end

      if experimental_freeze_constants
        val = experimental_freeze_constants
        RequireHooks.source_transform(patterns: patterns, exclude_patterns: exclude_patterns) do |path, source|
          source ||= File.read(path)
          "# shareable_constant_value: #{val}\n#{source}"
        end
      end
    end
  end

  self.experimental_freeze_constants = false
end

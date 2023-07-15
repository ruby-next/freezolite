# frozen_string_literal: true

require "freezolite/version"

module Freezolite
  class << self
    attr_accessor :watch_dirs

    def setup(watch_dirs:)
      self.watch_dirs = watch_dirs.freeze
      require "require-hooks/setup"

      ::RequireHooks.around_load do |path, &block|
        next block.call unless watch_dirs.any? { |dir| path.start_with?(dir) }

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

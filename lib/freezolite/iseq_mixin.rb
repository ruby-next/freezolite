module FreezeTheLits
  module IseqMixin
    def load_iseq(path)
      was_frozen_string_literal = RubyVM::InstructionSequence.compile_option[:frozen_string_literal]

      if FreezeTheLits.watch_dirs.any? { |dir| path.start_with?(dir) }
        RubyVM::InstructionSequence.compile_option = {frozen_string_literal: true}

        defined?(super) ? super : RubyVM::InstructionSequence.compile_file(path)
      else
        defined?(super) ? super : nil
      end
    ensure
      RubyVM::InstructionSequence.compile_option = {frozen_string_literal: was_frozen_string_literal}
    end
  end
end

RubyVM::InstructionSequence.singleton_class.prepend(FreezeTheLits::IseqMixin)

# frozen_string_literal: true

require "freeze_the_lits/version"

module FreezeTheLits
  class << self
    attr_accessor :watch_dirs

    def setup(watch_dirs:)
      self.watch_dirs = watch_dirs.freeze
      require "freeze_the_lits/iseq_mixin"
    end
  end
end

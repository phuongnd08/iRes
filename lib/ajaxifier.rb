module Ajaxifier
  module Helpers
    def use_placeholder?
      !persisted? && Ajaxifier.on?
    end
  end

  class << self
    def enable
      self.on = true
      yield
    ensure
      self.on = false
    end

    def on?
      on
    end

    def off?
      !on
    end

    private
    attr_accessor :on
  end
end

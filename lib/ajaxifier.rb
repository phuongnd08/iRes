module Ajaxifier
  module Helpers
    def use_placeholder?
      !persisted? && Ajaxifier.on?
    end

    def to_param
      if use_placeholder?
        "%{#{self.class.name.underscore}_id}"
      else
        super
      end
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

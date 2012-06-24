module NetworkHelper
  class Interface
    attr_accessor :interface

    IP_PATTERN = /inet addr\:(?<ip>\d+\.\d+\.\d+\.\d+)/
    MASK_PATTERN = /Mask\:(?<mask>\d+\.\d+\.\d+\.\d+)/
    BCAST_PATTERN = /Bcast\:(?<bcast>\d+\.\d+\.\d+\.\d+)/
    GATEWAY_PATTERN = /^0.0.0.0\s+(?<gateway>\d+\.\d+\.\d+\.\d+)\s+0.0.0.0/
    UNKNOWN_IP = "0.0.0.0"
    UNKNOWN_MASK = '255.255.255.255'
    UNKNOWN_BCAST = '0.0.0.0'
    UNKNOWN_GATEWAY = '0.0.0.0'

    def initialize(interface)
      self.interface = interface
    end

    def ifc_data
      @ifc_data ||= `ifconfig #{interface}`
    end

    def route_data
      @route_data ||= `route -n`
    end

    def ip
      if (match = ifc_data.match(IP_PATTERN))
        match[:ip]
      else
        UNKNOWN_IP
      end
    end

    def mask
      if (match = ifc_data.match(MASK_PATTERN))
        match[:mask]
      else
        UNKNOWN_MASK
      end
    end

    def bcast
      if (match = ifc_data.match(BCAST_PATTERN))
        match[:bcast]
      else
        UNKNOWN_BCAST
      end
    end

    def gateway
      if (match = route_data.match(GATEWAY_PATTERN))
        match[:gateway]
      else
        UNKNOWN_GATEWAY
      end
    end
  end

  class << self
    [:ip, :mask, :bcast].each do |method|
      define_method method do |interface|
        Interface.new(interface).send(method)
      end
    end
  end
end

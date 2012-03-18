module NetworkHelper
  class << self
    IP_PATTERN = /inet addr\:(?<ip>\d+\.\d+\.\d+\.\d+)/
    UNKNOWN_IP = "0.0.0.0"

    def ip_on_interface(interface)
      interface_data = `ifconfig #{interface}`
      if match = interface_data.match(IP_PATTERN)
        match[:ip]
      else
        UNKNOWN_IP
      end
    end
  end
end

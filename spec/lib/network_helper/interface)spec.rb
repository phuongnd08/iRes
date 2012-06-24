require 'spec_helper'

describe NetworkHelper do
  before do
    NetworkHelper.stub(:ifc_data).and_return %{
wlan0     Link encap:Ethernet  HWaddr 38:59:f9:24:2a:37
          inet addr:192.168.0.106  Bcast:192.168.0.255  Mask:255.255.255.0
          inet6 addr: fe80::3a59:f9ff:fe24:2a37/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:136094 errors:0 dropped:0 overruns:0 frame:0
          TX packets:128183 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:128412404 (128.4 MB)  TX bytes:21671181 (21.6 MB)
    }
  end

  describe ".ip_on" do
    it "returns ip on the current interface" do
      NetworkHelper.ip_on_interface("lo").should == "127.0.0.1"
    end
  end
end

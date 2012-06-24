require 'spec_helper'

describe NetworkHelper::Interface do
  let(:subject) { NetworkHelper::Interface.new('eth0') }

  before do
    subject.stub(:ifc_data).and_return %{
wlan0     Link encap:Ethernet  HWaddr 38:59:f9:24:2a:37
          inet addr:192.168.0.2  Bcast:192.168.0.255  Mask:255.255.255.0
          inet6 addr: fe80::3a59:f9ff:fe24:2a37/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:136094 errors:0 dropped:0 overruns:0 frame:0
          TX packets:128183 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:128412404 (128.4 MB)  TX bytes:21671181 (21.6 MB)
    }

    subject.stub(:route_data).and_return %{
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         192.168.0.1     0.0.0.0         UG    0      0        0 wlan0
169.254.0.0     0.0.0.0         255.255.0.0     U     1000   0        0 wlan0
192.168.0.0     0.0.0.0         255.255.255.0   U     2      0        0 wlan0
    }
  end

  {
    :ip => "192.168.0.2",
    :mask => "255.255.255.0",
    :bcast => "192.168.0.255",
    :gateway => "192.168.0.1"
  }.each do |method, value|
    its(method) { should == value }
  end
end

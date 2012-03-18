require 'spec_helper'

describe NetworkHelper do
  describe ".ip_on_interface" do
    it "returns ip on the current interface" do
      NetworkHelper.ip_on_interface("lo").should == "127.0.0.1"
    end
  end
end

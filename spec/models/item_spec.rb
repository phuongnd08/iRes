require 'spec_helper'

describe Item do
  describe "#enabled" do
    it "defaults to true" do
      Item.new.should be_enabled
    end
  end
end

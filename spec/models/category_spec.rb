require 'spec_helper'

describe Category do
  describe "#enabled" do
    it "defaults to true" do
      Category.new.should be_enabled
    end
  end
end

require 'spec_helper'

describe HomeController do

  describe "GET 'waiter'" do
    it "returns http success" do
      get 'waiter'
      response.should be_success
    end
  end

end

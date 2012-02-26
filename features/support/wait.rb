module WaitMethods
  def wait_for(value, wait_time = nil)
    wait_time ||= Capybara.default_wait_time
    started_at = Time.now
    res = nil
    begin
      res = yield
      sleep 0.5 unless res == value
    end while (started_at.to_i > wait_time.seconds.ago.to_i && res != value)
    res.should == value
  end
end

World(WaitMethods)


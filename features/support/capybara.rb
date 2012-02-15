Capybara.default_selector = :css
Capybara::Selenium::Driver::DEFAULT_OPTIONS[:resynchronize] = false
Capybara.default_wait_time = 5
browser = ENV["BROWSER"] || "chrome"
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => browser.to_sym)
end


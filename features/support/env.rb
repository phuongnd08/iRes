require 'rubygems'
require 'spork'

Spork.prefork do
require 'cucumber/rails'

Capybara.default_selector = :css
ActionController::Base.allow_rescue = false

end

Spork.each_run do
  Dir[Rails.root.join("test/support/**/*.rb")].each {|f| require f}
end

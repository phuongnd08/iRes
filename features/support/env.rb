require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'

  # Avoid routes preload => avoid user.rb preload
  require "rails/application"
  # avoid routing preload => avoid devise model preload
  Spork.trap_method(Rails::Application::RoutesReloader, :reload!)
  require File.expand_path("../../../config/environment", __FILE__)

  require 'cucumber/rails'
  require 'cucumber/rspec/doubles'
  ActiveRecord::Base.connection.disconnect!
end

Spork.each_run do
  ActiveRecord::Base.establish_connection
  DatabaseCleaner.clean_with(:truncation)
  I18n.backend.reload!
end


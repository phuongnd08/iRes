# vim: syn=ruby
source 'https://rubygems.org'

gem 'rails', '~> 3.2.5'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mysql2'
gem 'settingslogic'
gem 'thin'
gem 'squeel'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
  gem 'i18n-js'
  gem 'haml_assets'
  gem 'ejs'
end

gem 'jquery-rails'
gem 'haml-rails'
gem 'spreadsheet'
gem 'wicked_pdf'

group :test do
  gem 'capybara'
  gem 'cucumber-rails', :require => false
  gem 'machinist', '>= 2.0.0.beta2'
  gem 'database_cleaner'
  gem 'spork', '~> 0.9.0.rc9', :require  => false
end

group :development, :test do
  gem 'rspec-rails'
  gem 'debugger'
  gem 'jasminerice'
  gem 'chronic'
end

group :guard do
  gem 'guard', :require => false
  gem 'guard-spork', :require => false
  gem 'guard-rails', :require => false
  gem 'guard-bundler', :require => false
end

group :deploy do
  gem 'capistrano'
  gem 'rvm-capistrano'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the web server
# gem 'unicorn'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

# vim: syn=ruby
group :default do
  guard 'bundler' do
    watch('Gemfile')
  end

  guard 'rails', :port => 3000 do
    watch('Gemfile.lock')
    watch(%r{^config/initializers/.+\.rb$})
    watch('config/environments/development.rb')
    watch('config/application.rb')
  end
end

group :drb do
  guard 'spork' do
    watch('config/application.rb')
    watch('Gemfile')
    watch('Gemfile.lock')
    watch('config/environment.rb')
    watch('config/database.yml')
    watch(%r{^config/environments/.+\.rb$})
    #watch(%r{^lib/.+validator\.rb$})
    watch(%r{^config/initializers/.+\.rb$})
    watch('spec/spec_helper.rb')
    watch('feature/support/env.rb')
  end
end

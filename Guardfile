# vim: syn=ruby

require 'guard/guard'
require 'ruby-debug'

module ::Guard
  class Faye < Guard
    def start
      if pid = unmanaged_pid
        stop_pid pid
      end
      start_command = "cd push_server && push_bundle exec thin -C thin/production.yml -R config.ru start"
      puts "Starting Push Server with command #{start_command}"
      `#{start_command}`
      true
    end

    def stop
      if current_pid
        stop_pid(current_pid)
        `rm #{pidfile_path}`
      end
    end

    def reload
      stop
      start
    end

    def run_all
      true
    end

    def run_on_change(paths)
      true
    end

    private

    def pidfile_path
      "#{Dir.pwd}/push_server/tmp/thin.pid"
    end

    def stop_pid(pid)
      puts "Sending TERM signal to Push Server(#{pid})"
      Process.kill("TERM", pid)
      true
    end

    def current_pid
      File.exist?(pidfile_path) && File.read(pidfile_path).to_i
    end

    def unmanaged_pid
      str = %x{lsof -n -i TCP:3500}.each_line.detect { |line| line["*:3500"] }
      if str
        str.split("\s")[1].to_i
      else
        nil
      end
    end
  end
end

# Used just to quickly debug guard faye
group :faye do
  guard 'faye'
end

group :default do
  guard 'bundler' do
    watch('Gemfile')
  end

  guard 'rails', :port => 3000, :server => :thin do
    watch('Gemfile.lock')
    watch(%r{^config/initializers/.+\.rb$})
    watch(%r{^lib/.+\.rb$})
    watch('config/environments/development.rb')
    watch('config/application.rb')
  end

  guard 'faye'
end

group :demo do
  guard 'rails', :port => 8080, :server => :thin, :environment => :production
end

group :drb do
  guard 'spork' do
    watch('config/application.rb')
    watch('Gemfile')
    watch('Gemfile.lock')
    watch('config/environment.rb')
    watch('config/database.yml')
    watch(%r{^config/environments/.+\.rb$})
    watch(%r{^lib/.+\.rb$})
    watch(%r{^config/initializers/.+\.rb$})
    watch('spec/spec_helper.rb')
    watch('features/support/env.rb')
  end
end

require "rvm/capistrano"
require "bundler/capistrano"
load "deploy/assets"
set :application, "ires"
set :repository,  "git@github.com:phuongnd08/iRes.git"
set :rails_env, :production

set :scm, :git
set :branch, :master
set :user, "deploy"
set :use_sudo, false
ssh_options[:forward_agent] = true
set :deploy_via, :remote_cache
set :deploy_to, "/home/#{user}/#{application}"
set :target_server, ENV["SERVER"]
if target_server.nil?
  raise "Please set target_server with SERVER=ip_or_target_server (of the target machine)"
end


set :rvm_ruby_string, '1.9.3-p125@ires'
set :rvm_type, :system

set :bundle_flags,    "--deployment"
set :bundle_without,  [:development, :test, :deploy]

role :app, target_server
role :db, target_server, :primary => true                          # Your HTTP target_server, Apache/etc
role :web, target_server

namespace :deploy do
  task :start, :roles => [:web, :app] do
    run "cd #{current_path} && bundle exec thin -C thin/production.yml -R config.ru start"
  end

  task :stop, :roles => [:web, :app] do
    run "cd #{current_path} && bundle exec thin -C thin/production.yml -R config.ru stop"
  end

  task :restart, :roles => [:web, :app] do
    run "cd #{current_path} && bundle exec thin -C thin/production.yml -R config.ru restart"
  end
end

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

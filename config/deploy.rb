require "bundler/capistrano"
require "rvm/capistrano"

default_run_options[:pty] = true

set :application, "todobadour"
set :repository,  "git@github.com:sideshowcoder/Todobadour.git"
set :branch, "master"

set :scm, :git

set :rvm_ruby_string, "1.9.3"
set :rvm_type, :system

set :user, "deployer"
set :use_sudo, false
set :deploy_to, "/u/web/#{application}"
set :deploy_via, :remote_cache

role :web, "todobadour.sideshowcoder.com"                          # Webserver
role :app, "todobadour.sideshowcoder.com"                          # Appserver
role :db,  "todobadour.sideshowcoder.com", :primary => true        # Database Server

after 'deploy:update', 'foreman:export'
after 'deploy:update', 'foreman:restart'
after "deploy:update_code", "deploy:assets:precompile"

namespace :deploy do
  namespace :assets do
    task :precompile, :roles => :web, :except => { :no_release => true } do
      run "cd #{release_path} && RAILS_ENV=production bundle exec rake assets:precompile"
    end
  end
end

namespace :foreman do
  desc "Export the Procfile to Ubuntu's upstart scripts"
  task :export, :roles => :app do
    foreman_temp = "/tmp/#{application}-foreman"
    run [
      "mkdir -p #{foreman_temp}",
      "cd #{release_path}",
      "bundle exec foreman export upstart #{foreman_temp} -a #{application} -u #{user} -l #{shared_path}/log -f Procfile.production",
      "sudo mv #{foreman_temp}/#{application}*.conf /etc/init/",
      "rm -rf #{foreman_temp}"
    ].join('&&')
  end

  desc "Start the application services"
  task :start, :roles => :app do
    sudo "start #{application}"
  end

  desc "Stop the application services"
  task :stop, :roles => :app do
    sudo "stop #{application}"
  end

  desc "Restart the application services"
  task :restart, :roles => :app do
    run "sudo start #{application} || sudo restart #{application}"
  end

  desc "Display logs for a certain process - arg example: PROCESS=web-1"
  task :logs, :roles => :app do
    run "cd #{current_path}/log && cat #{ENV["PROCESS"]}.log"
  end
end

# stub out deploy:restart
namespace :deploy do
  task :restart do
  end
end
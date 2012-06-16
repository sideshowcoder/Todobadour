require "bundler/capistrano"
default_run_options[:pty] = true # Password prompt for git

set :application, "todobadour"
set :repository,  "git@github.com:sideshowcoder/Todobadour.git"

set :scm, :git

set :user, "deployer"
set :use_sudo, false
set :deploy_to, "/u/web/#{application}"
set :deploy_via, :remote_cache

role :web, "todobadour.sideshowcoder.com"                          # Webserver
role :app, "todobadour.sideshowcoder.com"                          # Appserver
role :db,  "todobadour.sideshowcoder.com", :primary => true        # Database Server

after 'deploy:update', 'foreman:export'
after 'deploy:update', 'foreman:restart'

after "deploy:update_code", "deploy:pipeline_precompile"

namespace :deploy do
  task :pipeline_precompile do
    run "cd #{release_path}; RAILS_ENV=production bundle exec rake assets:precompile"
  end
end

namespace :foreman do
  desc "Export the Procfile to Ubuntu's upstart scripts"
  task :export, :roles => :app do
    run "cd #{release_path} && sudo bundle exec foreman export upstart /etc/init -a #{application} -u #{user} -l #{shared_path}/log"
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
end
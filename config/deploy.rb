require 'bundler/capistrano'
load 'deploy/assets'

set :application, "asagao"
set :deploy_to, "/var/rails/asagao"
set :user, "rails"
set :use_sudo, false

set :repository, "."
set :scm, :none
set :deploy_via, :copy
set :copy_exclude, [ "doc", "log", "tmp" ]

set :normalize_asset_timestamps, false
set :keep_releases, 3

role :web, "asagao.oiax.jp:2222"
role :app, "asagao.oiax.jp:2222"
role :db,  "asagao.oiax.jp:2222", :primary => true

after "deploy:update", :roles => :app do
  run "cp #{shared_path}/config/database.yml #{release_path}/config/"
end

after "deploy:update", "deploy:cleanup"

namespace :deploy do
  desc "Restarts your application."
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

# config valid only for current version of Capistrano
lock '3.5.0'

#Cribbed from http://vstark.net/2012/08/21/rails-capistrano-git-bluehost/
set :application, 'pdx_db'
set :repo_url, 'git@github.com:rubyforgood/pdx_diaper.git'
set :user, "pdxdiape"
set :domain, "pdxdiaperbank.org"
set :use_sudo, false
set :scm, :git
set :branch, "master"
set :repository, "."
set :deploy_via, :copy
set :deploy_to, "/home/#{fetch(:user)}/rails_apps/#{fetch(:application)}"

server domain, :app, :web, :db, :primary => true

set :tmp_dir, "/home/pdxdiape/rails_apps/capistrano_tmp"
set :linked_files, %w{.env tmp/restart.txt}
set :linked_dirs, %w{public}

namespace :deploy do
	task :start do ; end
	task :stop do ; end

	task :restart, :roles => :app, :except => { :no_release => true } do
		run "touch #{File.join(current_path, 'tmp', 'restart.txt') }"
	end
end

after "deploy:restart", "deploy:cleanup"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

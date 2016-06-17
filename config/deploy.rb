# config valid only for current version of Capistrano
lock '3.5.0'

#Cribbed from http://vstark.net/2012/08/21/rails-capistrano-git-bluehost/
set :application, 'pdx_db'
set :repo_url, 'git@github.com:rubyforgood/pdx_diaper.git'
set :user, "pdxdiape"
set :use_sudo, false
set :scm, :git
set :branch, "master"
set :repository, "."
set :deploy_via, :copy
set :deploy_to, "/home1/#{fetch(:user)}/rails_apps/#{fetch(:application)}"
set :format, :pretty

set :tmp_dir, "/home1/pdxdiape/rails_apps/capistrano_tmp"
set :linked_files, fetch(:linked_files, []).push('.env', 'public/.htaccess')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'vendor/bundle', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system')

set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

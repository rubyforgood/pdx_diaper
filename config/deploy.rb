# config valid only for current version of Capistrano
lock '3.5.0'

#Cribbed from http://vstark.net/2012/08/21/rails-capistrano-git-bluehost/
set :application, 'pdx_db'
set :repo_url, 'git@github.com:rubyforgood/pdx_diaper.git'
set :user, "deploy"
set :use_sudo, false
set :scm, :git
set :branch, "master"
# set :repository, "."
# set :deploy_via, :copy
set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :format, :pretty

set :linked_files, fetch(:linked_files, []).push('.env')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'vendor/bundle', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system')

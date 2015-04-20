# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'RubyGryphon'
set :repo_url, 'git@github.com:mshappe/ruby-the-gryphon.git'
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :deploy_to, '/home/rubygryphon/app'
set :scm, :git
set :format, :pretty
set :log_level, :debug
set :pty, true
set :linked_files, fetch(:linked_files, []).push('config/secrets.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
set :keep_releases, 3

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }


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

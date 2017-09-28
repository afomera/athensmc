# config valid only for current version of Capistrano
lock '3.8.0'

SSHKit.config.command_map[:rake] = "bundle exec rake"

set :application, 'athensmc'
set :repo_url, 'git@git.athensmc.com:king601/AthensMC.git'
set :branch, 'master'
set :deploy_to, '/home/deploy/athensmc'
set :user, 'deploy'

set :linked_files, %w{config/database.yml config/secrets.yml .rbenv-vars}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets public/system}
# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app_name

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

namespace :rails do
  desc "Remote console"
  task :console do
    on roles(:app) do |h|
      run_interactively "bundle exec rails console #{fetch(:rails_env)}", h.user
    end
  end

  desc "Remote dbconsole"
  task :dbconsole do
    on roles(:app) do |h|
      run_interactively "bundle exec rails dbconsole #{fetch(:rails_env)}", h.user
    end
  end

  def run_interactively(command, user)
    info "Running `#{command}` as #{user}@#{host}"
    exec %Q(ssh #{user}@#{host} -t "bash --login -c 'cd #{fetch(:deploy_to)}/current && #{command}'")
  end
end

Rake::Task['deploy:assets:backup_manifest'].clear_actions
namespace :deploy do
  namespace :assets do
    task :backup_manifest do
      on roles(fetch(:assets_roles)) do
        within release_path do
          execute :cp,
                  release_path.join('public', fetch(:assets_prefix), '.sprockets-manifest*'),
                  release_path.join('assets_manifest_backup')
        end
      end
    end
  end
end

  # config valid only for current version of Capistrano
  lock '3.4.0'
  set :rbenv_ruby,    '2.3.0'
  set :application,   'kazuki'
  set :repo_url,      'git@github.com:sasajpn/achieve.git'
  set :branch,        'master'
  set :deploy_to,     '/var/www/rails/achieve'
  set :linked_dirs,   fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
  set :keep_releases, 3
  set :linked_files, %w{config/database.yml}
  set :linked_files, fetch(:linked_files, []).push('config/secrets.yml')
  
  namespace :deploy do
    desc 'Restart application'
    task :restart do
      invoke 'unicorn:restart'
    end
    desc 'Create database'
    task :db_create do
      on roles(:db) do |host|
        with rails_env: fetch(:rails_env) do
          within current_path do
            execute :bundle, :exec, :rake, 'db:create'
          end
        end
      end
    end
    desc 'Run seed'
    task :seed do
      on roles(:app) do
        with rails_env: fetch(:rails_env) do
          within current_path do
            execute :bundle, :exec, :rake, 'db:seed'
          end
        end
      end
    end
    after :publishing, :restart
    after :restart,    :clear_cache do
      on roles(:web), in: :groups, limit: 3, wait: 10 do; end
    end
    after :finished,   :cleanup
  end
  
  namespace :deploy do

  # 上記linked_filesで使用するファイルをアップロードするタスク
  desc 'Upload database.yml'
  task :upload do
    on roles(:app) do |host|
      if test "[ ! -d #{shared_path}/config ]"
        execute "mkdir -p #{shared_path}/config"
      end
      upload!('config/database.yml', "#{shared_path}/config/database.yml")
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app) do
      invoke 'unicorn:restart'
    end
  end
end
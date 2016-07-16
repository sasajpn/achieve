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
  
  # linked_filesで使用するファイルをアップロードするタスクは、deployが行われる前に実行する必要がある
  before 'deploy:starting', 'deploy:upload'
  # Capistrano 3.1.0 からデフォルトで deploy:restart タスクが呼ばれなくなったので、ここに以下の1行を書く必要がある
  after 'deploy:publishing', 'deploy:restart'
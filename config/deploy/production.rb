set :stage, :production
set :rails_env, "production"
set :unicorn_rack_env, "production"

# この設定がないと、デプロイ先でdb:migrateされない
set :migration_role, 'db'

role :app, %w{USER_NAME@IP_ADDRESS}
role :web, %w{USER_NAME@IP_ADDRESS}
role :db,  %w{USER_NAME@IP_ADDRESS}, :primary => true
#role :db,  %w{USER_NAME@IP_ADDRESS}

server '52.69.140.80', user: 'kazuki', roles: %w{web app db}

set :ssh_options, {
    keys: [File.expand_path('~/.ssh/first_aws_rsa')],
    forward_agent: true,
    auth_methods: %w(password),
    password: 'password'
}
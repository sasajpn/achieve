server 'server-sasa.win',
user:  'sasahara',
roles: %w{app db web}
set :ssh_options,
port: '9724',
keys: File.expand_path('~/.ssh/id_rsa')

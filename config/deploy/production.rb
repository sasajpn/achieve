server '150.95.131.121',
user:  'sasahara',
roles: %w{app db web}
set :ssh_options, {
port: '9724',
keys: File.expand_path('~/.ssh/id_rsa'),
}

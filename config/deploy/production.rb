server 'server-sasa.win',
user:  'kazuki',
roles: %w{app db web}
set :sshoptions, 
keys: File.expand_path('~/.ssh/id_rsa')

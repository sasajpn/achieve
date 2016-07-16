  server   '52.69.140.80',
    user:  'kazuki',
    roles: %w{app db web},
    ssh_options: {
      keys: [
        # for ec2
        File.expand_path('~/.ssh/first_aws_rsa'),
        # for github
        File.expand_path('~/.ssh/aws_git_rsa')
      ],
      forward_agent: true,
      auth_methods: %w(publickey)
    }
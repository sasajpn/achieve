  # Load DSL and set up stages
  require 'capistrano/setup'
  # Include default deployment tasks
  require 'capistrano/deploy'
  # Include tasks from other gems included in your Gemfile
  require 'capistrano/rbenv'
  require 'capistrano/bundler'
  require 'capistrano/rails/assets'
  require 'capistrano/rails/migrations'
  # Include slack notifier
  # require 'slackistrano'
  # Load custom tasks from `lib/capistrano/tasks` if you have any defined
  Dir.glob('lib/capistrano/tasks/*.cap').each { |r| import r }
# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings =
# {
#     :user_name => ENV['SENDGRID_USERNAME'],
#     :password => ENV['SENDGRID_PASSWORD'],
#     :domain => "heroku.com",
#     :address => "smtp.sendgrid.net",
#     :port => 587,
#     :authentication => :plain,
#     :enable_starttls_auto => true
# }
    {
      :enable_starttls_auto => true,
      :address => "smtp.gmail.com",
      :port => 587,
      :domain => 'smtp.gmail.com',
      user_name: "achieve.dic.sasahara@gmail.com",
      password: "gbrolnwkpkmtfuwj",
      :authentication => 'plain'
    }
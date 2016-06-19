# Use a different logger for distributed setups.
 # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

 # Use a different cache store in production.
 # config.cache_store = :mem_cache_store

 # Enable serving of images, stylesheets, and JavaScripts from an asset server.
 # config.action_controller.asset_host = 'http://assets.example.com'

 # Ignore bad email addresses and do not raise email delivery errors.
 # Set this to true and configure the email server for immediate delivery to raise delivery errors.
 config.action_mailer.raise_delivery_errors = true
 config.action_mailer.delivery_method = :smtp
 host = 'blooming-ridge-58222.herokuapp.com'
 config.action_mailer.default_url_options = { host: host }
 ActionMailer::Base.smtp_settings =
 {
   :user_name => ENV['SENDGRID_USERNAME'],
   :password => ENV['SENDGRID_PASSWORD'],
   :domain => "heroku.com",
   :address => "smtp.sendgrid.net",
   :port => 587,
   :authentication => :plain,
   :enable_starttls_auto => true
 }

 # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
 # the I18n.default_locale when a translation cannot be found).
 config.i18n.fallbacks = true

 # Send deprecation notices to registered listeners.
 config.active_support.deprecation = :notify

 # Use default logging formatter so that PID and timestamp are not suppressed.
 config.log_formatter = ::Logger::Formatter.new

 # Do not dump schema after migrations.
 config.active_record.dump_schema_after_migration = false
end

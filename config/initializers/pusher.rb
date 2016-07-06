require 'pusher'
 
 # Pusher.app_id = ENV['PUSHER_APP_ID']
 # Pusher.key = ENV['PUSHER_KEY']
 # Pusher.secret = ENV['PUSHER_SECRET']
 
 # Pusher.app_id = "222452"
 # Pusher.key = "31f8f29da9da9065dbfa"
 # Pusher.secret = "b606bf29221facff149f"
 
  pusher_client = Pusher::Client.new(
  app_id: "222452",
  key: "31f8f29da9da9065dbfa",
  secret: "b606bf29221facff149f",
  encrypted: true
  )
  
 # Pusher.logger = Rails.logger
 # Pusher.encrypted = true
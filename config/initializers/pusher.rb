require 'pusher'
 
 # Pusher.app_id = ENV['PUSHER_APP_ID']
 # Pusher.key = ENV['PUSHER_KEY']
 # Pusher.secret = ENV['PUSHER_SECRET']
 
 # Pusher.app_id = "222452"
 # Pusher.key = "31f8f29da9da9065dbfa"
 # Pusher.secret = "b606bf29221facff149f"
 
Pusher.app_id = '222452'
Pusher.key = '31f8f29da9da9065dbfa'
Pusher.secret = 'b606bf29221facff149f'
Pusher.logger = Rails.logger
Pusher.encrypted = true
  
 # Pusher.logger = Rails.logger
 # Pusher.encrypted = true
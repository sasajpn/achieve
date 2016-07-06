class NotificationsController < ApplicationController
  def index
    @notifications = Notification.where(recipient_id: current_user.id).order(created_at: :desc)
    @notifications.update_all(read: true)
  end
    
end

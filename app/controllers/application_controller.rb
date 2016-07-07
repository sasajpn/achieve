class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include UsersHelper
  
  before_action :current_notifications
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  
  def current_notifications
    @notifications = Notification.where(recipient_id: current_user).order(created_at: :desc)
    @notifications_count = Notification.where(recipient_id: current_user).order(created_at: :desc).unread.count
  end
  
  protected
    def configure_permitted_parameters
      # devise_parameter_sanitizer.permit(:account_update) do |user_params|
      #   user_params.permit(:name, :image, :remove_image, :profile)
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:image])
      devise_parameter_sanitizer.permit(:account_update, keys: [:remove_image])
      devise_parameter_sanitizer.permit(:account_update, keys: [:profile])
      # end
    end
end

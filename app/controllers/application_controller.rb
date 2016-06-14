class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include UsersHelper
  
  rescue_from Exception, with: :handle_500 unless Rails.env.development?
  rescue_from ActionController::RoutingError, with: :handle_404 unless Rails.env.development?
  rescue_from ActiveRecord::RecordNotFound, with: :handle_404 unless Rails.env.development?
  
  def handle_500(exception = nil)
    logger.info "Rendering 500 with exception: #{exception.message}" if exception
    render template: 'errors/error_500', status: 500, layout: 'application', content_type: 'text/html'
  end
  
  def handle_404(exception = nil)
    logger.info "Rendering 404 with exception: #{exception.message}" if exception
    render template: 'errors/error_404', status: 404, layout: 'application', content_type: 'text/html'
  end
  
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  
  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:account_update) << :name
      devise_parameter_sanitizer.for(:account_update) << :image
      devise_parameter_sanitizer.for(:account_update) << :remove_image
      devise_parameter_sanitizer.for(:account_update) << :profile
    end
end

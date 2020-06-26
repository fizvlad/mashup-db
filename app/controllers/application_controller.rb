class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :push_to_flash_alerts

  private

  # Allowed types: 'primary', 'secondary', 'success', 'danger', 'warning', 'info', 'light', 'dark'
  def push_to_flash_alerts(text = '', type: 'info')
    flash[:alerts] ||= []
    flash[:alerts] << { 'type' => type.to_s, 'text' => text.to_s }
  end
end

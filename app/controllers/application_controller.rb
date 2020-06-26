class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :push_to_flash_alerts

  helper_method :not_authenticated

  before_action :require_login

  private

  # Allowed types: 'primary', 'secondary', 'success', 'danger', 'warning', 'info', 'light', 'dark'
  def push_to_flash_alerts(text = '', type: 'info')
    flash[:alerts] ||= []
    flash[:alerts] << { 'type' => type.to_s, 'text' => text.to_s }
  end

  # before_action
  def require_matching_user
    return if current_user == @user

    push_to_flash_alerts 'This action requires you to be logged in as another user.', type: 'danger'
    redirect_to root_path
  end

  # Used by Sorcery
  def not_authenticated
    redirect_to main_app.login_path, alert: 'Please login first'
  end
end

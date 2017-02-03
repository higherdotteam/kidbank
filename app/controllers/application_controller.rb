class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    pid = session[:person_id]
    return nil if pid == nil
    @current_user ||= Customer.find_by_id(pid)
  end
end

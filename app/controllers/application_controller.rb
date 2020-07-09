class ApplicationController < ActionController::Base
  def current_user
    return unless session[:email]
    @current_user ||= User.find(session[:email])
  end
end

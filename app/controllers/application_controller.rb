class ApplicationController < ActionController::Base
  #def utente_attuale
  #  return unless session[:email]
  #  @current_user ||= User.find(session[:email])
  #end
  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?
  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:surname,:address,:gender])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name,:surname,:address,:gender])
    end
end

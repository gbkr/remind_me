class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email,
                                                                   :time_zone,
                                                                   :password,
                                                                   :password_confirmation,
                                                                   :current_password
                                                                  ) }
  end
end
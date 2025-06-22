class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :role ])
  end

  def after_sign_in_path_for(resource)
    if resource.doctor?
      doctor_root_path
    else
      receptionist_root_path
    end
  end
end

class ApplicationController < ActionController::Base
  before_action :configre_permitted_parameters, if: :devise_controller?

  def configre_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :location_id, :department_id, :bed, :service_years, :license, :company])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :location_id, :department_id, :bed, :service_years, :license, :company])    
  end

  def other_user
    other_user = User.where.not(nickname: current_user.nickname)
  end
  
end

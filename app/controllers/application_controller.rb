class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def check_authentication
    # binding.pry
    # return true if request.method == 'GET'
    redirect_to '/login' unless current_user
  end

  def check_authorization
    redirect_to '/login' unless current_user.manager?
  end


# Only allow a trusted parameter "white list" through.
  # By default, all parameters are permitted.To enable a white list,
  # define the PERMITTED_PARAMETERS constant array in each resource
  # controller.
  def permitted_resource_params
    params.require(resource_name.to_sym).permit(*self.class::PERMITTED_PARAMETERS) if self.class::PERMITTED_PARAMETERS
  end


  def resource_name
    @resource_name ||= controller_name.singularize
  end
end








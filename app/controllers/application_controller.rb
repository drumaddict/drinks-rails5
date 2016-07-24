class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :set_up

  def set_up
    @companies= Company.all
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def check_authentication
    redirect_to '/login' unless current_user
  end

  def get_per
    begin
      model_per = resource_class::KAMINARI_RECORDS_PER_PAGE
    rescue NameError
      model_per = false
    end
    default_per = model_per || self.resource_class::KAMINARI_RECORDS_PER_PAGE || Kaminari.config.default_per_page
    page_params[:per] || default_per
  end

  def get_page
    page_params[:page] || 1
  end

  def page_params
    params.permit(:page, :per, :format, :id)
  end


# The resource class based on the controller
  # @return [Class]
  def resource_class
    @resource_class ||= resource_name.classify.constantize
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








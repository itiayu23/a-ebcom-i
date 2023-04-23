class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  # before_action :set_search
  
  # def set_search
  #   @novel_search = Tag.ransack(params[:q])
  #   @search_write = @novel_search.result
  #   @pict_search = PictTag.ransack(params[:q])
  #   @search_draw = @pict_search.result
  # end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :nickname, :birthday])
  end
end

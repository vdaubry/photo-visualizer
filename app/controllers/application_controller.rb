class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @user ||= User.where(id: session[:user_id]).first
  end
  helper_method :current_user
  
  def authenticate_user!
    redirect_to root_path unless current_user
  end
  
end

class SessionsController < ApplicationController
  def create
    user = User.where(email: params[:email]).first
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id.to_s
      flash[:notice] = "Vous êtes authentifié"
      redirect_to '/'
    else
      flash[:alert] = "Identifiants incorrects"
      redirect_to '/'
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = "Vous êtes déconnecté"
    redirect_to '/'
  end
end
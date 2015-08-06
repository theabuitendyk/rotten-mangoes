class SessionsController < ApplicationController

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url
    
    # user = User.find_by(email: params[:email])

    # if user && user.authenticate(params[:password])
    #   session[:user_id] = user.id
    #   redirect_to movies_path, notice: "Welcome back, #{user.firstname}!"
    # else
    #   flash.now[:alert] = "Log in failed..."
    #   render :new
    # end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Goodbye!"
  end

end

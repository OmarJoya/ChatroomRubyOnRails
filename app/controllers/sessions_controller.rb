class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Login successfully"
      redirect_to root_path
    else
      flash.now[:error] = "Wrong login credentials"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end

class SessionsController < ApplicationController
  def new
  end
  
  def create
      user = User.find_by(username: login_params[:username])
      if user && user.authenticate(login_params[:password])
          session[:user_id] = user.id
          redirect_to dashboard_path
      else
          flash[:login_errors] = ["Username or Password incorrect!"]
          redirect_to sign_in_path
      end
  end
  def destroy
      session[:user_id] = nil
      redirect_to sign_in_path, notice: 'Logged out!'
  end

  private
    def login_params
        params.require(:login).permit(:username,:password)
    end
  
end

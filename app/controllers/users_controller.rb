class UsersController < ApplicationController
  def index
       @school = [['school1', 'school1'],['school2', 'school2'],['school3', 'school3'],['school4', 'school4'],['school5', 'school5']]
  end
  
  def create
      user = User.new(user_params)
      if user.save
          session[:user_id] = user.id
          redirect_to dashboard_path
      else
          flash[:login_errors] = user.errors.full_messages
          redirect_to sign_up_path
          #render 'index'
      end
  end
  
  private
    def user_params
       params.require(:user).permit(:username,:password,:password_confirmation,:school) 
    end
end

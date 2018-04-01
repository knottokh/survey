class UsersController < ApplicationController

  def index
      # @school = [['school1', 'school1'],['school2', 'school2'],['school3', 'school3'],['school4', 'school4'],['school5', 'school5']]
       @master_case = 0;
       @school = School.all;
       role = Role.where(name:"user").first
       @roleid =(role.nil?)?0:role.id

  end
  
  def create

      user = User.new(user_params)
      
      
      if user.save
          session[:user_id] = user.id
          loghis = Loghistory.new({behavior:1,user_id:user.id});
          if loghis.save
            
          else
   
         end
          redirect_to dashboard_path
      else
          flash[:login_errors] = user.errors.full_messages
          #flash[:login_errors] = user_params
          redirect_to sign_up_path
          #render 'index'
      end
  end
  
  private
    def user_params
       params.require(:user).permit(:username,:password,:password_confirmation,:school_id,:role_id) 
    end
end

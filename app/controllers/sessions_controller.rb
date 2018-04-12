class SessionsController < ApplicationController
  def new
      @master_case = 0;
  end
  
  def create
      user = User.find_by(username: login_params[:username])
      if user && user.authenticate(login_params[:password])
          session[:user_id] = user.id
          loghis = Loghistory.new({behavior:2,user_id:user.id});
          if loghis.save
            
          else
   
          end
          redirect_to dashboard_path
      else
          flash[:login_errors] = ["Username or Password incorrect!"]
          redirect_to root_path
      end
  end
  def destroy
      loghis = Loghistory.new({behavior:3,user_id:session[:user_id]});
      if loghis.save
            
          else
   
       end
      session[:user_id] = nil
      session[:master_case] = nil
      session["formparam"] = nil
      session.delete :locale
      redirect_to root_path, notice: 'Logged out!'
  end

  private
    def login_params
        params.require(:login).permit(:username,:password)
    end
  
end

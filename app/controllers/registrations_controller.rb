class RegistrationsController < Devise::RegistrationsController
 def new
     @schools = ["School A","School B","School C","School D"]
    super
    
 end
 
 private

  def sign_up_params
    params.require(:user).permit(:school,:username,:email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:school,:username,:email,:password, :password_confirmation, :current_password)
  end
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  #before_action :authenticate_user!
  
  protected
  def authenticate_user!
      unless User.find_by(id: session[:user_id])
          redirect_to sign_in_path , notice:"You trying to access without permission!"
      end
  end
  
end

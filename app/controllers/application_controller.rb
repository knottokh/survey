class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :getheadertext
  before_action :set_locale
  #before_action :authenticate_user!,master_case
  
  def set_locale
    I18n.locale = params[:locale] || session[:locale] || I18n.default_locale
    session[:locale] = "th"
  end
  protected
  def getheadertext

    txt =  "โครงการศึกษาสภาพและแนวทางในการจัดการทรัพยากรดนตรีศึกษาใน
                    สถานศึกษาของประเทศไทย: มิติการกำหนดและขับเคลื่อนนโยบาย
                    กระทรวงวัฒนธรรม"
    @headtitle = txt
  end
  def authenticate_user!
      unless User.find_by(id: session[:user_id])
          redirect_to sign_in_path , notice:"You trying to access without permission!"
      end
  end
  def role_user!
      user  = User.find_by(id: session[:user_id])
      if !user.nil?
          if user.role.name != 'user'
            redirect_to admin_path , notice:"You trying to access without permission role User!"
          end
      end
  end
  def role_admin!
      user  = User.find_by(id: session[:user_id])
      if !user.nil?
          if user.role.name != 'admin'
            redirect_to dashboard_path , notice:"You trying to access without permission role Admin!"
          end
      end
  end
  def master_case
    return  unless session[:master_case]
    @master_case ||= session[:master_case]
  end
end

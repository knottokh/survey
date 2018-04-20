# frozen_string_literal: true

class Allusers::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
   def new
      if flash[:user_params].nil? 
            flash[:user_params]= {}
      end
      @master_case = 0;
       @privatehead = "นโยบายความเป็นส่วนตัว*"
       @private1 = "1. กระทรวงวัฒนธรรม ให้ความสำคัญอย่างยิ่งกับข้อมูลส่วนบุคคลและ
ความเป็นส่วนตัวของท่าน การจัดการข้อมูลต่างๆ ของท่านจะเป็นไป
อย่างปลอดภัย และนำใช้เฉพาะการจัดการฐานข้อมูลในการวิจัยเท่านั้น"
       @private21 = "2. กระทรวงวัฒนธรรม สัญญาว่าจะ"     
       @private221 = "เก็บรักษา"
       @private222 ="ไม่เปิดเผย"
       @private23 = "และ"
       @private24 = "ป้องกัน"
       @private25 = "การเข้าถึงข้อมูลส่วนตัวต่าง ๆ ที่สามารถระบุตัวตนของท่านออกสู่สาธารณะ"
       @schoolblank = "ชื่อสถานศึกษา หรือ รหัสสถานศึกษา*"
       @school = School.all;
       role = Role.where(name:"user").first
       @roleid =(role.nil?)?0:role.id
     super
   end

  # POST /resource
   def create
       #super
      user = Alluser.new(new_alluser_params)
      
      
      if user.save
          session[:user_id] = user.id
          loghis = Loghistory.new({behavior:1,user_id:user.id});
          if loghis.save
            
          else
   
          end
          redirect_to dashboard_path
      else

          flash[:user_params]= new_alluser_params
          flash[:user_params].each do |k,v|
              checkinside = user.errors[k]
              if !checkinside.empty?
                  flash[:user_params][k] = nil
              end
              
          end
          flash[:login_errors_obj] = user.errors
          flash[:login_errors] = user.errors.full_messages
          #flash[:login_errors] = user_params
          redirect_to sign_up_path
          #render 'index'
      end
   end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  private
    def new_alluser_params
       params.require(:alluser).permit(:username,:password,:password_confirmation,
                        :school_id,:role_id,:prefix,:name,:surname,:cardnumber,:position,
                        :phone,:email) 
    end
end

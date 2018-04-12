class UsersController < ApplicationController

  def index
      # @school = [['school1', 'school1'],['school2', 'school2'],['school3', 'school3'],['school4', 'school4'],['school5', 'school5']]
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

          flash[:user_params]= user_params
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
  
  private
    def user_params
       params.require(:user).permit(:username,:password,:password_confirmation,
                        :school_id,:role_id,:name,:lastname,:cardnumber,:position,
                        :phone,:email) 
    end
end

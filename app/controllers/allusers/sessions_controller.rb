# frozen_string_literal: true

class Allusers::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
   def new
         session.destroy
          @master_case = 0;
          @newusertext = "ลงทะเบียนผู้ให้ข้อมูลครั้งแรก"
           @tosurveytext = "เข้าสู่ระบบกรอกข้อมูล"
           @headsub1 ="สืบเนื่องจาก คณะกรรมการวัฒนธรรมแห่งชาติ (กวช.) เห็นชอบให้กระทรวงวัฒนาธรรมดำเนินการตามนโยบายส่งเสริมให้เด็กไทยทุกคน
    เล่นดนตรีไทยเป็น 1 ชนิด ภายใน 5 ปี ดังนั้นจึงมีความจำเป็นต้องเก็บรวบรวมข้อมูลทรัพยากรด้านดนตรีศึกษาของสถานศึกษา
    ในประเทศไทยเพื่อใช้เป็นข้อมูลหลักสำหรับการกำหนดนโยบายสนับสนุนสถานศึกษาให้เป็นไปอย่างเหมาะสม และมีประสิทธิผล"
           @headwarning = "กระทรวงวัฒนธรรมจึงใคร่ขอความกรุณาสถานศึกษาให้ข้อมูลที่ครบถ้วน และตรงตามสภาพจริง ข้อมูลของท่านจะมีส่วนสำคัญอย่าง
    ยิ่งในการกำหนดนโยบาย และวางแผน
    เพื่อพัฒนาการจัดการเรียนการสอนดนตรีศึกษาของประเทศ"
         @forgetpassowrd ="ลืมรหัสผ่าน?"
         #session[:alluser_id] = nil
         #if session[:user_id] != nil
           #redirect_to dashboard_path
         #end
        super
   end

  # POST /resource/sign_in
  def create
      user = Alluser.find_by(username: new_alluser_params[:login])
      if user && user.authenticatable(new_alluser_params[:password])
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

  # DELETE /resource/sign_out
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

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  private
    def new_alluser_params
        params.require(:alluser).permit(:login,:password)
    end
end

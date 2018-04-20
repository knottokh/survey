class PagesController < ApplicationController
  before_action :authenticate_user! ,:role_user!, except: [:index]
  #before_action :role_user!
  def index
       @master_case = 0;
       @newusertext = "ลงทะเบียนผู้ให้ข้อมูลครั้งแรก"
       @tosurveytext = "เข้าสู่ระบบกรอกข้อมูล"
       @headsub1 ="สืบเนื่องจาก คณะกรรมการวัฒนธรรมแห่งชาติ (กวช.) เห็นชอบให้กระทรวงวัฒนาธรรมดำเนินการตามนโยบายส่งเสริมให้เด็กไทยทุกคน
เล่นดนตรีไทยเป็น 1 ชนิด ภายใน 5 ปี ดังนั้นจึงมีความจำเป็นต้องเก็บรวบรวมข้อมูลทรัพยากรด้านดนตรีศึกษาของสถานศึกษา
ในประเทศไทยเพื่อใช้เป็นข้อมูลหลักสำหรับการกำหนดนโยบายสนับสนุนสถานศึกษาให้เป็นไปอย่างเหมาะสม และมีประสิทธิผล"
       @headwarning = "กระทรวงวัฒนธรรมจึงใคร่ขอความกรุณาสถานศึกษาให้ข้อมูลที่ครบถ้วน และตรงตามสภาพจริง ข้อมูลของท่านจะมีส่วนสำคัญอย่าง
ยิ่งในการกำหนดนโยบาย และวางแผน
เพื่อพัฒนาการจัดการเรียนการสอนดนตรีศึกษาของประเทศไทย"    
       #session[:user_id] = nil
       if session[:user_id] != nil
         redirect_to dashboard_path
       end
  end
  def create
      #qustions = Question.all
      user = User.find_by(id: session[:user_id])
      error_count = 0;
      track = Array.new 
      track.push(params[:qparam])
      #@pages = Pages.new(params[:qparam])
      #tracharr.push(@pages)
      params[:qparam].each do |k, v|
        #v['contact_ids'] = [ v['contact_ids'] ] unless v['contact_ids'].is_a?(Array)
         if !v.nil? && !v.empty?
              karr = k.split('-') 
              case karr[0]
                when "qid"
                    qid = Integer(karr[1])  
                    behavior = 0;
                    answer = Answer.where(:question_id=>qid).where(:school_id=>user.school_id).first
                    if answer.nil?
                          behavior = 4;
                          #new data
                          #tracharr.push("new case")
                          ans = Answer.new({answer:v,question_id:qid,school_id:user.school_id});
                          if ans.save
                              track.push("save success")
                          else
                              error_count+=1
                              track.push("save error")
                          end
                          
                    else
                        #update data
                         #tracharr.push("update case")
                          if answer.answer != v
                             behavior = 5;
                              answer.update({answer:v});
                              if answer.save
                                   track.push("update success")
                              else
                                  error_count+=1
                                  track.push("update error")
                              end
                          end
                        #redirect_to dashboard_path
                    end
                    
                    #Log history
                    if behavior > 0
                        loghistory({behavior:behavior,answer:v,question_id:qid,user_id:user.id},track)
                    end
                   #answer = User.find_by(id: session[:user_id])
                #else
                #  "You gave me #{x} -- I have no idea what to do with that."
              end
          end
      end
      flash[:question_errors] = track
      redirect_to form1_path
      if error_count == 0
        
         
      end
  end
  def show
     @master_case = 0;
     user = User.find_by(id: session[:user_id])
     
     loguserlogin = Loghistory.where(:user_id => 10,:behavior => "2").last
     #loglogin = Loghistory.where()
     #I18n.locale = :th
     @userlogintime = ""#I18n.l(Date.current) 
     if !loguserlogin.nil?
          @userlogintime = I18n.l(loguserlogin.created_at.in_time_zone("Bangkok"), format: :long)#loguserlogin.created_at.strftime("%d-%m-%Y")
     end     
     
     #count teacher
        qteacher =  Question.find_by({:title => "teachercount"})
        
                        #.page(params[:page])
        teachercount  = 0
        maxteacher = 0
            if !qteacher.nil?
            tanswer = Answer.where(:question_id=>qteacher.id).where(:school_id=>user.school_id).first
            if !tanswer.nil?
                    if !tanswer.answer.nil? && !tanswer.answer.empty?
                        maxteacher = Integer(tanswer.answer) 
                        teachercount = teachercount + 1
                    end
                    #session["qid-#{q.id}"] = nil
            end
        end

        teacers = Musicteacher.where(:schools_id=>user.school_id)
        teacers.each do |tea|
            #if !tea.nil?
                if (!tea.prefix.nil? && !tea.prefix.empty?)
                    teachercount = teachercount + 1
                end
                if (!tea.name.nil? && !tea.name.empty?) 
                    teachercount = teachercount + 1
                end
                if (!tea.surname.nil? && !tea.surname.empty?)
                    teachercount = teachercount + 1
                end
                if (!tea.status.nil? && !tea.status.empty?)
                    teachercount = teachercount + 1
                end
                if (!tea.position.nil? && !tea.position.empty?)
                    teachercount = teachercount + 1
                end
                if (!tea.degree.nil? && !tea.degree.empty?)
                    teachercount = teachercount + 1
                end
                if (!tea.branch.nil? && !tea.branch.empty?)
                    teachercount = teachercount + 1
                end
                if (!tea.university.nil? && !tea.university.empty?)
                    teachercount = teachercount + 1
                end
                if (!tea.topic.nil? && !tea.topic.empty?)
                    
                     teachercount = teachercount + 1
                end
                #session["qid-#{q.id}"] = nil
            #end
        end
     maxform1 = (9.0 * maxteacher) + 1
     #@formpercent = (teachercount/maxform1)*100.0
     
     #count thai music
     formdata2 = getMusicFormInfo(2,{})
     formdata3 = getMusicFormInfo(3,{})
     formdata4 = getMusicFormInfo(4,{})
     
     qmaxform2 = formdata2["allQ"]
     qmaxform3 = formdata3["allQ"]
     qmaxform4 = formdata4["allQ"]
     
     amaxform2 = formdata2["allA"]
     amaxform3 = formdata3["allA"]
     amaxform4 = formdata4["allA"]
     
     allcount =  maxform1+qmaxform2+qmaxform3+qmaxform4
     ansall = teachercount+amaxform2+amaxform3+amaxform4
     @percentall = (ansall).percent_of(allcount)  
     @percentform1 = (teachercount).percent_of(maxform1)  
     @percentform2 = (amaxform2).percent_of(qmaxform2)  
     @percentform3 = (amaxform3).percent_of(qmaxform3)   
     @percentform4 = (amaxform4).percent_of(qmaxform4)  
     @text1 = 0#checktext(@percentform1)
     @text2 = 0#checktext(@percentform2)
     @text3 = 0#checktext(@percentform3)
     @text4 = 0#checktext(@percentform4)
     
  end
  def form1
     #session.destroy
    @master_case = 1; 
    if session["formparam"].nil? 
        session["formparam"]= {}
    end
    user = User.find_by(id: session[:user_id])
    @questions = Question.joins(:musicin).where(:musicins => {formtype: 1})
                    #.page(params[:page])
    @questions.each do |q|
        answer = Answer.where(:question_id=>q.id).where(:school_id=>user.school_id).first
        if !answer.nil?
            session["formparam"]["qid-#{q.id}"] = answer.answer
            #session["qid-#{q.id}"] = nil
        end
    end
    #params["qparam"]["qid1"] = 'B'
    #session[:qparam]  = Array.new 
    #session["qid1"] = 'A'
    #session[:qid2] = 'B'
    #session[:qid3] = 'A'
    #session[:qid4] = 'B'
  end
  private
  def checktext(percent)
     if percent == 100
         return "แก้ไข"
      elsif percent === 0
        return "กรอกข้อมูล"
      else 
         return "กรอกข้อมูลต่อ"
      end
          
  end       
  def loghistory(param,track)
        #1 sign up
        #2 log in
        #3 log out
        #4 new data
        #5 update data
        loghis = Loghistory.new(param);
        if loghis.save
            track.push("log success")
        else
            track.push("log error")
        end
  end

end
class Numeric
  def percent_of(n)
    self.to_f / n.to_f * 100.00
  end
end

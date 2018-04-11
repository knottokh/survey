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
          @userlogintime = loguserlogin.created_at
     end     
     
     #count teacher
        qteacher =  Question.find_by({:title => "teachercount"})
        
                        #.page(params[:page])
        teachercount  = 0
        maxteacher = 0
        tanswer = Answer.where(:question_id=>qteacher.id).where(:school_id=>user.school_id).first
        if !tanswer.nil?
                if !tanswer.answer.nil? && !tanswer.answer.empty?
                    maxteacher = Integer(tanswer.answer) 
                    teachercount = teachercount + 1
                end
                #session["qid-#{q.id}"] = nil
        end
        
        teacers = Musicteacher.where(:schools_id=>user.school_id)
        teacers.each do |tea|
            if !tea.nil?
                if (!tea.prefix.nil? && !tea.prefix.empty?) || (!tea.name.nil? && !tea.name.empty?) ||
                    (!tea.surname.nil? && !tea.surname.empty?) || (!tea.status.nil? && !tea.status.empty?) ||
                    (!tea.position.nil? && !tea.position.empty?) || (!tea.degree.nil? && !tea.degree.empty?) ||
                    (!tea.branch.nil? && !tea.branch.empty?) || (!tea.university.nil? && !tea.university.empty?) ||
                    (!tea.topic.nil? && !tea.topic.empty?)
                    
                     teachercount = teachercount + 1
                end
                #session["qid-#{q.id}"] = nil
            end
        end
        
        @formpercent = (teachercount/((9.0 * maxteacher) + 1))*100.0
     
     #count thai music
      qcountthaimusic = Question.joins(:musicin).where(:musicins => {formtype: 2})
                        #.page(params[:page])
      countthaimusic  = 0
      qcountthaimusic.each do |q|
            answer = Answer.where(:question_id=>q.id).where(:school_id=>user.school_id).first
            if !answer.nil?
                if !answer.answer.nil? && !answer.answer.empty?
                    countthaimusic = countthaimusic + 1
                end
                if !answer.answer2.nil? && !answer.answer2.empty?
                    countthaimusic = countthaimusic + 1
                end
                #session["qid-#{q.id}"] = nil
            end
       end
     allform1 = (9.0 * maxteacher) + 1;
     allform2 = qcountthaimusic.count * 2;
     #allform3 = Question.where(formtype:3).count;
     #allform4 = Question.where(formtype:4).count;
     allcount = allform1+allform2#+allform3+allform4;
     #ansform1 = Answer.where(school_id:user.school_id).joins(:question).where(questions: {formtype:1}).count
     #ansform2 = Answer.where(school_id:user.school_id).joins(:question).where(questions: {formtype:2}).count
     #ansform3 = Answer.where(school_id:user.school_id).joins(:question).where(questions: {formtype:3}).count
     #ansform4 = Answer.where(school_id:user.school_id).joins(:question).where(questions: {formtype:4}).count
     ansall = teachercount+countthaimusic#+ansform3+ansform4;
     @percentall = (ansall).percent_of(allcount)  
     @percentform1 = (teachercount).percent_of(allform1)  
     @percentform2 = (countthaimusic).percent_of(allform2)  
     @percentform3 = 0#ansform3==0?0:(ansform3).percent_of(allform3)  
     @percentform4 = 0#ansform4==0?0:(ansform4).percent_of(allform4)
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

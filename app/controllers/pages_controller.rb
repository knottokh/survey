class PagesController < ApplicationController
  before_action :authenticate_user! ,:role_user!, except: [:index]
  #before_action :role_user!
  def index
       @master_case = 0;
       @newusertext = "ลงทะเบียนผู้ใช้ใหม่"
       @tosurveytext = "กรอกข้อมูลต่อ"
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
     @master_case = 1;
      user = User.find_by(id: session[:user_id])
     allform1 = Question.where(formtype:1).count;
     allform2 = Question.where(formtype:2).count;
     allform3 = Question.where(formtype:3).count;
     allform4 = Question.where(formtype:4).count;
     allcount = allform1+allform2+allform3+allform4;
     ansform1 = Answer.where(school_id:user.school_id).joins(:question).where(questions: {formtype:1}).count
     ansform2 = Answer.where(school_id:user.school_id).joins(:question).where(questions: {formtype:2}).count
     ansform3 = Answer.where(school_id:user.school_id).joins(:question).where(questions: {formtype:3}).count
     ansform4 = Answer.where(school_id:user.school_id).joins(:question).where(questions: {formtype:4}).count
     ansall = ansform1+ansform2+ansform3+ansform4;
     @percentall = (ansall).percent_of(allcount)  
     @percentform1 = ansform1==0?0:(ansform1).percent_of(allform1)  
     @percentform2 = ansform2==0?0:(ansform2).percent_of(allform2)  
     @percentform3 = ansform3==0?0:(ansform3).percent_of(allform3)  
     @percentform4 = ansform4==0?0:(ansform4).percent_of(allform4)
     @text1 = checktext(@percentform1)
     @text2 = checktext(@percentform2)
     @text3 = checktext(@percentform3)
     @text4 = checktext(@percentform4)
     
  end
  def form1
     #session.destroy
    @master_case = 1; 
    if session["formparam"].nil? 
        session["formparam"]= {}
    end
    user = User.find_by(id: session[:user_id])
    @questions = Question.where(formtype:1).page(params[:page])
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

class ThaiMusicsController < ApplicationController
    def index
        @master_case = 0; 
        if session["formparam"].nil? 
            session["formparam"]= {}
        end
        user = User.find_by(id: session[:user_id])
        questions = Question.joins(:musicin).where(:musicins => {formtype: 2})
                        #.page(params[:page])
        anscount  = 0
        questions.each do |q|
            answer = Answer.where(:question_id=>q.id).where(:school_id=>user.school_id).first
            if !answer.nil?
                session["formparam"]["qid-#{q.id}"] = answer.answer
                session["formparam"]["qid-#{q.id}-2"] = answer.answer2
                if !answer.answer.nil? && !answer.answer.empty?
                    anscount = anscount + 1
                end
                if !answer.answer2.nil? && !answer.answer2.empty?
                    anscount = anscount + 1
                end
                #session["qid-#{q.id}"] = nil
            end
        end
        @q1 = Musicin.find_by(id: 2)
        @q2 = Musicin.find_by(id: 14)
        @question1 =  questions.where(:musicin_id => @q1.id)
        @question2 =  questions.where(:musicin_id => @q2.id)
        
        @formpercent = (anscount/(questions.count*2.0))*100.0
        
        @answers1 = Answer.where(:musicin_id => @q1.id)
        @answers1.each do |ans|
            session["formparam"]["titleans-#{ans.id}"] = ans.othertitle
            session["formparam"]["ans-#{ans.id}"] = ans.answer
            session["formparam"]["ans-#{ans.id}-2"] = ans.answer2
        end
        #@questions.group_by(&:musicin_id)
    end
    
    #Post
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
        if !v.nil?
              karr = k.split('-') 
              case karr[0]
                when "qid"
                    if karr.length == 2
                        qid = Integer(karr[1])  
                        v2 = params[:qparam]["qid-#{qid}-2"]
                        behavior = 0;
                        answer = Answer.where(:question_id=>qid).where(:school_id=>user.school_id).first
                        if answer.nil?
                              behavior = 4;
                              #new data
                              #tracharr.push("new case")
                              ans = Answer.new({answer:v,answer2:v2,question_id:qid,school_id:user.school_id});
                              if ans.save
                                  track.push("save success")
                              else
                                  error_count+=1
                                  track.push("save error")
                              end
                        else
                            #update data
                             #tracharr.push("update case")
                              if answer.answer != v || answer.answer2 != v2 
                                 behavior = 5;
                                  answer.update({answer:v,answer2:v2});
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
                            loghistory({behavior:behavior,answer:v,answer2:v2,question_id:qid,user_id:user.id},track)
                        end
                    end
                   #answer = User.find_by(id: session[:user_id])
                                
                when "othertitle"
                    objv = Array(v)
                    musid = Integer(karr[1])
                    objans1 = Array(params[:qparam]["otherval-#{musid}"])
                    objans2 = Array(params[:qparam]["otherval2-#{musid}"])
                    objv.each_with_index do |vd,index|
                         behavior = 0;    
                         if !vd.nil? && !vd.empty?
                             behavior = 4;
                              #new data
                              #tracharr.push("new case")
                              ans = Answer.new({answer:objans1[index],answer2:objans2[index],othertitle:vd,musicin_id:musid,school_id:user.school_id});
                              if ans.save
                                  track.push("save success")
                              else
                                  error_count+=1
                                  track.push("save error")
                              end
                        end
                        #Log history
                        if behavior > 0
                            loghistory({behavior:behavior,answer:objans1[index],answer2:objans2[index],othertitle:vd,musicin_id:musid,user_id:user.id},track)
                        end
                    end
                when "titleans"
                    if karr.length == 2
                        ansid = Integer(karr[1])
                        anstext= params[:qparam]["ans-#{ansid}"]
                        anstext2 =params[:qparam]["ans-#{ansid}-2"]
                        answer = Answer.find_by(id: ansid)
                        behavior = 0;  
                        if !answer.nil?
                            if answer.answer != anstext || answer.answer2 != anstext2 || answer.othertitle != v 
                                 behavior = 5;
                                  answer.update({othertitle:v,answer:anstext,answer2:anstext2});
                                  if answer.save
                                       track.push("update success")
                                  else
                                      error_count+=1
                                      track.push("update error")
                                  end
                             end
                        end
                        if behavior > 0
                            loghistory({behavior:behavior,answer:anstext,answer2:anstext2,othertitle:v,musicin_id:answer.musicin_id,user_id:user.id},track)
                        end
                    end
                #else
                #  "You gave me #{x} -- I have no idea what to do with that."
               end
               
        end
      end
      flash[:question_errors] = track
      redirect_to thaimusic_path
      if error_count == 0
        
         
      end
  end
  def delete
      otherans = Answer.find(params[:id])
      otherans.destroy
      redirect_to thaimusic_path
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
        #6 delete data
        loghis = Loghistory.new(param);
        if loghis.save
            track.push("log success")
        else
            track.push("log error")
        end
  end
end

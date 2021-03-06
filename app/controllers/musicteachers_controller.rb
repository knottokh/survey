class MusicteachersController < ApplicationController
    def index
        @master_case = 0; 
        if session["formparam"].nil? 
            session["formparam"]= {}
        end
        user = User.find_by(id: session[:user_id])
        questioncont =  Question.find_by({:title => "teachercount"})
        
                        #.page(params[:page])
        anscount  = 0
        
        answer = Answer.where(:question_id=>questioncont.id).where(:school_id=>user.school_id).first
        if !answer.nil?
                session["formparam"]["countteachers"] = answer.answer
                if !answer.answer.nil? && !answer.answer.empty?
                    anscount = anscount + 1
                end
                #session["qid-#{q.id}"] = nil
        end
        
        @teacers = Musicteacher.where(:schools_id=>user.school_id)
        @teacers.each do |tea|
            if !tea.nil?
                session["formparam"]["teaprefix-#{tea.id}"] = tea.prefix
                session["formparam"]["name-#{tea.id}"] = tea.name
                session["formparam"]["surname-#{tea.id}"] = tea.surname
                session["formparam"]["status-#{tea.id}"] = tea.status
                session["formparam"]["position-#{tea.id}"] = tea.position
                session["formparam"]["degree-#{tea.id}"] = tea.degree
                session["formparam"]["branch-#{tea.id}"] = tea.branch
                session["formparam"]["university-#{tea.id}"] = tea.university
                session["formparam"]["topic-#{tea.id}"] = tea.topic
                session["formparam"]["remark-#{tea.id}"] = tea.remark
                if (!tea.prefix.nil? && !tea.prefix.empty?) || (!tea.name.nil? && !tea.name.empty?) ||
                    (!tea.surname.nil? && !tea.surname.empty?) || (!tea.status.nil? && !tea.status.empty?) ||
                    (!tea.position.nil? && !tea.position.empty?) || (!tea.degree.nil? && !tea.degree.empty?) ||
                    (!tea.branch.nil? && !tea.branch.empty?) || (!tea.university.nil? && !tea.university.empty?) ||
                    (!tea.topic.nil? && !tea.topic.empty?)
                    anscount = anscount + 1
                end
                #session["qid-#{q.id}"] = nil
            end
        end
        maxteacher = Integer(session["formparam"]["countteachers"]) 
        @formpercent = (anscount/((9.0 * maxteacher) + 1))*100.0
        
        #@answers1 = Answer.where(:musicin_id => @q1.id)
        #@answers1.each do |ans|
        #    session["formparam"]["titleans-#{ans.id}"] = ans.othertitle
        #    session["formparam"]["ans-#{ans.id}"] = ans.answer
        #    session["formparam"]["ans-#{ans.id}-2"] = ans.answer2
        #end
        #@questions.group_by(&:musicin_id)
        deffobj = maxteacher - @teacers.length
        @diff = Array.new(deffobj)
    end
    def create
        user = User.find_by(id: session[:user_id])
        error_count = 0;
        track = Array.new 
        track.push(params[:qparam])
        #add answer all
        params[:qparam].each do |k, v|
            karr = k.split('-') 
            case karr[0]
                when "countteachers"
                    if !v.nil? && !v.empty?
                         behavior = 0;
                         questioncont =  Question.find_by({:title => "teachercount"})
                         if !questioncont.nil?
                            answer = Answer.where(:question_id=> questioncont.id).where(:school_id=>user.school_id).first
                             if answer.nil?
                                          behavior = 4;
                                          #new data
                                          #tracharr.push("new case")
                                          ans = Answer.new({answer:v,question_id:questioncont.id,school_id:user.school_id});
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
                                loghistory({behavior:behavior,answer:v,question_id:questioncont.id,user_id:user.id},track)
                            end
                         end
                    end
                when "teaprefix" 
                    tid = Integer(karr[1])  
                    tprefix = v
                    tname = params[:qparam]["name-#{tid}"]
                    tsurname = params[:qparam]["surname-#{tid}"]
                    tstatus = params[:qparam]["status-#{tid}"]
                    tposition = params[:qparam]["position-#{tid}"]
                    tdegree = params[:qparam]["degree-#{tid}"]
                    tbranch = params[:qparam]["branch-#{tid}"]
                    tuniversity = params[:qparam]["university-#{tid}"]
                    ttopic = params[:qparam]["topic-#{tid}"]
                    tremark = params[:qparam]["remark-#{tid}"]
                    
                    teacher = Musicteacher.find_by(id: tid)
                    
                    behavior = 0;  
                        if !teacher.nil?
                            if teacher.prefix != tprefix || teacher.name != tname || teacher.surname != tsurname || teacher.status != tstatus || teacher.position != tposition || teacher.degree != tdegree || teacher.branch != tbranch || teacher.university != tuniversity || teacher.topic != ttopic || teacher.remark != tremark
                                 behavior = 5;
                                  teacher.update({
                                            prefix:tprefix,
                                            name:tname,
                                            surname:tsurname,
                                            status:tstatus,
                                            position:tposition,
                                            degree:tdegree,
                                            branch:tbranch,
                                            university:tuniversity,
                                            topic:ttopic,
                                            remark:tremark
                                  });
                                  if teacher.save
                                       track.push("update success")
                                  else
                                      error_count+=1
                                      track.push("update error")
                                  end
                             end
                        end
                        #Log history
                        if behavior > 0
                            logteacherhistory({
                                            behavior:behavior,
                                            prefix:tprefix,
                                            name:tname,
                                            surname:tsurname,
                                            status:tstatus,
                                            position:tposition,
                                            degree:tdegree,
                                            branch:tbranch,
                                            university:tuniversity,
                                            topic:ttopic,
                                            remark:tremark,
                                            users_id:user.id
                            },track)
                        end
                when "prefix"    
                    tprefix = Array(v)
                    tname = Array(params[:qparam]["name"])
                    tsurname = Array(params[:qparam]["surname"])
                    tstatus = Array(params[:qparam]["status"])
                    tposition = Array(params[:qparam]["position"])
                    tdegree = Array(params[:qparam]["degree"])
                    tbranch = Array(params[:qparam]["branch"])
                    tuniversity = Array(params[:qparam]["university"])
                    ttopic = Array(params[:qparam]["topic"])
                    tremark = Array(params[:qparam]["remark"])
                    tprefix.each_with_index do |vd,index|
                         behavior = 0;    
                         if (!vd.nil? && !vd.empty?)  && (!tname[index].nil? && !tname[index].empty?)
                             behavior = 4;
                              #new data
                              #tracharr.push("new case")
                              ans = Musicteacher.new({
                                            prefix:vd,
                                            name:tname[index],
                                            surname:tsurname[index],
                                            status:tstatus[index],
                                            position:tposition[index],
                                            degree:tdegree[index],
                                            branch:tbranch[index],
                                            university:tuniversity[index],
                                            topic:ttopic[index],
                                            remark:tremark[index],
                                            schools_id:user.school_id
                                      });
                              if ans.save
                                  track.push("save success")
                              else
                                  error_count+=1
                                  track.push("save error")
                              end
                         end
                        #Log history
                        if behavior > 0
                            logteacherhistory({
                                            behavior:behavior,
                                            prefix:vd,
                                            name:tname[index],
                                            surname:tsurname[index],
                                            status:tstatus[index],
                                            position:tposition[index],
                                            degree:tdegree[index],
                                            branch:tbranch[index],
                                            university:tuniversity[index],
                                            topic:ttopic[index],
                                            remark:tremark[index],
                                            users_id:user.id
                            },track)
                        end
                end    
            end
        end
        #add teacher info
        
        
        flash[:question_errors] = track
          redirect_to musicteacher_path
          if error_count == 0
            
             
          end
    end
    def delete
      mteacer = Musicteacher.find(params[:id])
      mteacer.destroy
      redirect_to musicteacher_path
  end
    
    private
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
    def logteacherhistory(param,track)
        #1 sign up
        #2 log in
        #3 log out
        #4 new data
        #5 update data
        loghis = Logmusicteacher.new(param);
        if loghis.save
            track.push("log success")
        else
            track.push("log error")
        end
    end
end

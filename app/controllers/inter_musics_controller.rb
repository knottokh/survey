class InterMusicsController < ApplicationController
    def index
        @master_case = 0; 
        #if session["formparam"].nil? 
        session["formparam"]= {}
        #end
        formdata = getMusicFormInfo(3,session["formparam"])
        @formarray = formdata["alldata"]
        @formpercent = formdata["percent"]
        @musicclass = classMusicNotice
        #@questions.group_by(&:musicin_id)
    end
    
    #Post
  def create
      #qustions = Question.all
      saveandupdateMusics(params[:qparam])
      
      #flash[:question_errors] = track
      redirect_to intermusic_path
  end
  def delete
      deleteMusic(params[:id])
      redirect_to intermusic_path
  end
end

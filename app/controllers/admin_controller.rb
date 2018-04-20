class AdminController < ApplicationController
  #before_action :authenticate_user!, onlys: [index]
  #before_action :role_admin!
  def index
     @master_case = 2;
     if flash[:question_errors].nil?
        flash[:question_errors] = Array.new
        flash[:question_errors] .push("test")
     end
     #@schools = School.all
     #@schools = School.joins('LEFT JOIN answers ON answers.school_id = schools.id').select("*
     #                            ,(Select count(*) from questions where formtype IN (1,2,3,4)) as ques_mex
     #                            ,(Select count(*) from questions where formtype = 1) as ques1_count 
     #                            ,(Select count(*) from questions where formtype = 2) as ques2_count 
     #                            ,(Select count(*) from questions where formtype = 3) as ques3_count 
     #                            ,(Select count(*) from questions where formtype = 4) as ques4_count 
     #                            ,(Select count(*) from answers LEFT JOIN questions ON answers.question_id = questions.id where answers.school_id = schools.id and questions.formtype IN (1,2,3,4)) as ans_max 
     #                            ,(Select count(*) from answers LEFT JOIN questions ON answers.question_id = questions.id where answers.school_id = schools.id and questions.formtype = 1) as ans1_count 
     #                            ,(Select count(*) from answers LEFT JOIN questions ON answers.question_id = questions.id where answers.school_id = schools.id and questions.formtype = 2) as ans2_count 
     #                            ,(Select count(*) from answers LEFT JOIN questions ON answers.question_id = questions.id where answers.school_id = schools.id and questions.formtype = 3) as ans3_count 
     #                            ,(Select count(*) from answers LEFT JOIN questions ON answers.question_id = questions.id where answers.school_id = schools.id and questions.formtype = 4) as ans4_count
     #                            ,(Select count(*) from users where users.school_id = schools.id) as user_school 
     #                            ").group("id").order("id")

      @schools = School.schoolpercent.limit(10)
      #                            .having(!(params[:pfilter]).nil? ? params[:pfilter][:procress] : "")     
      #                            .order("percent_max desc")
     # @schools = School.all
                                # .paginate(:page => params[:page], :per_page => 50)
                                   #.where(!(params[:pfilter]).nil? ? params[:pfilter][:procress] : "")  
                                  #.where("percent_max >= 0")
                                  
                                  #.page(params[:page])#.per(2)
                                  
  end
  def show
      @master_case = 2;
      @schools = School.schoolpercent.having(params[:pfilter][:procress]).order("percent_max desc")
                .paginate(:page => params[:page], :per_page => 50)
     # @schools = schools.where(params[:pfilter][:procress])
      #          .paginate(:page => params[:page], :per_page => 2)
          #.page(params[:page]).per(2)
      tracking = Array.new
      tracking.push(params[:pfilter][:procress])
      tracking.push(params[:page])
      
      flash[:question_errors] = tracking
      flash[:procress]  = params[:pfilter][:procress]
      render action: :index
  end
  def exportTo
      @todolistall = Musicin.all
      filename = "exportnaja"
      respond_to do |format|
        format.html
        format.csv { send_data to_csv(@todolistall,nil)}
        format.json { send_data @todolistall.as_json}
        #format.xls { send_data to_csv(@todolistall,nil,{col_sep: '\t'}) }
        #format.csv {send_data Iconv.conv('iso-8859-1//IGNORE', 'utf-8', to_csv(@todolistall,nil,{encoding: 'UTF-8'})),
        #              :type => 'text/csv; charset=iso-8859-1; header=present',
        #              :disposition => "attachment; filename=#{filename}.csv"}
        #format.xlsx { send_data to_csv(@todolistall)}
       
      end
  end
  def import
   
  end
  def importpost
      tablecol = nil
      model = nil
      case params[:dbtable]
        when "School"
            model = School
            tablecol  = ["education_area","ministry_code","school_name","municipal_area","district","province","postcode","zone","students_count"]
        when "Question"
            model = Question
            tablecol  = ["title","qtype","musicin_id"]    
      end
      if !tablecol.nil? && !model.nil?        
          importfile(model,tablecol,params[:file])
          flash[:importmsg] = ["Import Success"]
      else
          flash[:importmsg] = ["Can't Import"]
      end
      render action: :import
  end
end

class School < ApplicationRecord
    scope :schoolpercent, -> {
        joins('LEFT JOIN answers ON answers.school_id = schools.id').select("*
                                  ,((Select count(*) from answers LEFT JOIN questions ON answers.question_id = questions.id where answers.school_id = schools.id  and questions.formtype IN (1,2,3,4))
                                    /((Select count(*) from questions where formtype IN (1,2,3,4))*1.00)
                                    *100.00
                                  ) as percent_max
                                  ,((Select count(*) from answers LEFT JOIN questions ON answers.question_id = questions.id where answers.school_id = schools.id  and questions.formtype = 1)
                                    /((Select count(*) from questions where formtype = 1)*1.00)
                                    *100.00
                                  ) as percent_1
                                  ,((Select count(*) from answers LEFT JOIN questions ON answers.question_id = questions.id where answers.school_id = schools.id  and questions.formtype = 2)
                                    /((Select count(*) from questions where formtype = 2)*1.00)
                                    *100.00
                                  ) as percent_2
                                  ,((Select count(*) from answers LEFT JOIN questions ON answers.question_id = questions.id where answers.school_id = schools.id  and questions.formtype = 3)
                                    /((Select count(*) from questions where formtype = 3)*1.00)
                                    *100.00
                                  ) as percent_3
                                  ,((Select count(*) from answers LEFT JOIN questions ON answers.question_id = questions.id where answers.school_id = schools.id  and questions.formtype = 4)
                                    /((Select count(*) from questions where formtype = 4)*1.00)
                                    *100.00
                                  ) as percent_4
                                  ,(Select count(*) from users where users.school_id = schools.id) as user_school 
                                  ").group("id")
    }
    has_many :users
    has_many :answers, through: :users
    
    def self.filter(params)
        where(params[:search])
    end
end

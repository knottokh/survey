class School < ApplicationRecord
    scope :schoolpercent, -> {
        left_joins(:answers).select("*
                                  ,((Select count(*) from answers INNER JOIN questions ON answers.question_id = questions.id where answers.school_id = schools.id  and questions.formtype IN (1,2,3,4))
                                    /((Select count(*) from questions where formtype IN (1,2,3,4))*1.00)
                                    *100.00
                                  ) percent_max
                                  ,((Select count(*) from answers INNER JOIN questions ON answers.question_id = questions.id where answers.school_id = schools.id  and questions.formtype = 1)
                                    /((Select count(*) from questions where formtype = 1)*1.00)
                                    *100.00
                                  ) percent_1
                                  ,((Select count(*) from answers INNER JOIN questions ON answers.question_id = questions.id where answers.school_id = schools.id  and questions.formtype = 2)
                                    /((Select count(*) from questions where formtype = 2)*1.00)
                                    *100.00
                                  ) percent_2
                                  ,((Select count(*) from answers INNER JOIN questions ON answers.question_id = questions.id where answers.school_id = schools.id  and questions.formtype = 3)
                                    /((Select count(*) from questions where formtype = 3)*1.00)
                                    *100.00
                                  ) percent_3
                                  ,((Select count(*) from answers INNER JOIN questions ON answers.question_id = questions.id where answers.school_id = schools.id  and questions.formtype = 4)
                                    /((Select count(*) from questions where formtype = 4)*1.00)
                                    *100.00
                                  ) percent_4
                                  ,(Select count(*) from users where users.school_id = schools.id) user_school 
                                  ").group("id")
    }
    has_many :users
    has_many :answers#, through: :users, source: :school
    has_many :musicteachers
    
    def self.filter(params)
        where(params[:search])
    end
end

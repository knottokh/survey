class SchoolDatatable < AjaxDatatablesRails::Base

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
        school_name: { source: "School.school_name", cond: :like, searchable: true, orderable: true },
        ministry_code:  { source: "School.ministry_code",  cond: :like  },
        students_count:        { source: "School.students_count" , searchable: false, orderable: true},
        percent_1:             { source: "percent_1" , searchable: false, orderable: false},
        percent_2:        { source: "percent_2" , searchable: false, orderable: false},
        percent_3:        { source: "percent_3" , searchable: false, orderable: false},
        percent_4:        { source: "percent_4" , searchable: false, orderable: false},
        percent_all:        { source: "percent_all" , searchable: false, orderable: false},
        userinscool:        { source: "userinscool" , searchable: false, orderable: true},
        district:        { source: "School.district" , searchable: false, orderable: false},
        id:        { source: "School.id" , searchable: false, orderable: false },
      }
  end

  def data
    
    records.map do |record|
      {
        # example:
        school_name:      record.school_name,
        ministry_code:    record.ministry_code,
        students_count:   record.students_count,
        district:   record.district,
        percent_1:        record.percent_1,
        percent_2:    record.percent_2,
        percent_3:   record.percent_3,
        percent_4:      record.percent_4,
        percent_all:    record.percent_all,
        userinscool:   record.userinscool,
        id:   record.id,
      }
    end
  end

  private
  def  get_raw_records
     School.schoolpercent
  end
  def get_raw_records2
    # insert query here
        q1 = Question.joins(:musicin).where(:musicins => {formtype:1}).last.id
        q2max = Question.joins(:musicin).where(:musicins => {formtype:2}).count * 2.00
        q3max = Question.joins(:musicin).where(:musicins => {formtype:3}).count * 2.00
        q4max = Question.joins(:musicin).where(:musicins => {formtype:4}).count * 2.00 
    School.select("*,	(
                                (    (
                                      (select (sum (m) + 1) mms from ( select (
                                        ((CASE WHEN  (T.prefix IS NOT NULL AND T.prefix <> '' ) THEN 1 ELSE 0 END)
                                        + (CASE WHEN (T.name IS NOT NULL AND T.name <> '') THEN 1 ELSE 0 END)
                                        + (CASE WHEN (T.surname IS NOT NULL AND T.surname <> '') THEN 1 ELSE 0 END)
                                        + (CASE WHEN (T.status IS NOT NULL AND T.status <> '')  THEN 1 ELSE 0 END)
                                        + (CASE WHEN (T.position IS NOT NULL AND T.position <> '') THEN 1 ELSE 0 END)
                                        + (CASE WHEN (T.degree IS NOT NULL  AND T.degree <> '') THEN 1 ELSE 0 END)
                                        + (CASE WHEN (T.branch IS NOT NULL AND T.branch <> '') THEN 1 ELSE 0 END)
                                        + (CASE WHEN (T.university IS NOT NULL AND T.university <> '') THEN 1 ELSE 0 END)
                                        + (CASE WHEN (T.topic IS NOT NULL  AND T.topic <> '') THEN 1 ELSE 0 END)) 
                                      ) m
                                      from musicteachers T  where T.schools_id =  schools.id)
                                      ) 
                                      /
                                     ( (
                                     
                                        select SUM(a.answer)
                                            from answers a INNER JOIN questions q on a.question_id = q.id 
                                           where  a.school_id = schools.id and  a.question_id = #{q1} 
                                      
                                      ) * 9.00 +1)
                                      ) * 100
                                      )
                                    ) percent_1,
                                    ( 
                                     (  (select sum(m) from (
                                        select (
                                            ((CASE WHEN  (A.answer IS NOT NULL AND A.answer <> '' ) THEN 1 ELSE 0 END)
                                            + (CASE WHEN (A.answer2 IS NOT NULL  AND A.answer2 <> '') THEN 1 ELSE 0 END)) 
                                          ) m from answers A INNER JOIN questions Q on A.question_id = Q.id 
                                          INNER JOIN musicins M on Q.musicin_id = M.id 
                                          Where A.school_id = schools.id and M.formtype = 2
                                          )
                                        ) / #{q2max} ) * 100
                                    
                                  ) percent_2,( 
                                     (  (select sum(m) from (
                                        select (
                                            ((CASE WHEN  (A.answer IS NOT NULL AND A.answer <> '' ) THEN 1 ELSE 0 END)
                                            + (CASE WHEN (A.answer2 IS NOT NULL  AND A.answer2 <> '') THEN 1 ELSE 0 END)) 
                                          ) m from answers A INNER JOIN questions Q on A.question_id = Q.id 
                                          INNER JOIN musicins M on Q.musicin_id = M.id 
                                          Where A.school_id = schools.id and M.formtype = 3
                                          )
                                        ) / #{q3max} ) * 100
                                    
                                  ) percent_3,( 
                                     (  (select sum(m) from (
                                        select (
                                            ((CASE WHEN  (A.answer IS NOT NULL AND A.answer <> '' ) THEN 1 ELSE 0 END)
                                            + (CASE WHEN (A.answer2 IS NOT NULL  AND A.answer2 <> '') THEN 1 ELSE 0 END)) 
                                          ) m from answers A INNER JOIN questions Q on A.question_id = Q.id 
                                          INNER JOIN musicins M on Q.musicin_id = M.id 
                                          Where A.school_id = schools.id and M.formtype = 4
                                          )
                                        ) / #{q4max} ) * 100
                                    
                                  ) percent_4,( 
                                    (
                                      (select (sum (m) + 1) from ( select (
                                        ((CASE WHEN  (T.prefix IS NOT NULL AND T.prefix <> '' ) THEN 1 ELSE 0 END)
                                        + (CASE WHEN (T.name IS NOT NULL AND T.name <> '') THEN 1 ELSE 0 END)
                                        + (CASE WHEN (T.surname IS NOT NULL AND T.surname <> '') THEN 1 ELSE 0 END)
                                        + (CASE WHEN (T.status IS NOT NULL AND T.status <> '')  THEN 1 ELSE 0 END)
                                        + (CASE WHEN (T.position IS NOT NULL AND T.position <> '') THEN 1 ELSE 0 END)
                                        + (CASE WHEN (T.degree IS NOT NULL  AND T.degree <> '') THEN 1 ELSE 0 END)
                                        + (CASE WHEN (T.branch IS NOT NULL AND T.branch <> '') THEN 1 ELSE 0 END)
                                        + (CASE WHEN (T.university IS NOT NULL AND T.university <> '') THEN 1 ELSE 0 END)
                                        + (CASE WHEN (T.topic IS NOT NULL  AND T.topic <> '') THEN 1 ELSE 0 END)) 
                                      ) m
                                      from musicteachers T  where T.schools_id =  schools.id)
                                      ) 
                                      +
                                      (select sum(m) from (
                                        select (
                                            ((CASE WHEN  (A.answer IS NOT NULL AND A.answer <> '' ) THEN 1 ELSE 0 END)
                                            + (CASE WHEN (A.answer2 IS NOT NULL  AND A.answer2 <> '') THEN 1 ELSE 0 END)) 
                                          ) m from answers A INNER JOIN questions Q on A.question_id = Q.id 
                                          INNER JOIN musicins M on Q.musicin_id = M.id 
                                          Where A.school_id = schools.id and M.formtype IN (2,3,4)
                                          )
                                        )
                                      )
                                      /
                                      ( 
                                        ( (
                                     
                                            select SUM(a.answer)
                                                from answers a INNER JOIN questions q on a.question_id = q.id 
                                               where  a.school_id = schools.id and  a.question_id = #{q1} 
                                          
                                          ) * 9.00 +1)
                                          +
                                          #{ q2max + q3max + q4max}
                                       ) * 100
                                     ) percent_all,(Select count(users.id) from users where users.school_id = schools.id) userinscool")
  end

  # ==== These methods represent the basic operations to perform on records
  # and feel free to override them

  # def filter_records(records)
  # end

  # def sort_records(records)
  # end

  # def paginate_records(records)
  # end

  # ==== Insert 'presenter'-like methods below if necessary
end

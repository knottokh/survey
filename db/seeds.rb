# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#School.create(name:'school 1',code:'00001',description:"description school 1")
#School.create(name:'school 2',code:'00002',description:"description school 2")
#School.create(name:'school 3',code:'00003',description:"description school 3")
#School.create(name:'school 4',code:'00004',description:"description school 4")
#School.create(name:'school 5',code:'00005',description:"description school 5")

#Question.create(title:'question 1',qtype:'dropdown',choice:'A,B');
#Question.create(title:'question 2',qtype:'text');
#Question.create(title:'question 3',qtype:'radio',choice:'A,B');

#Answer.create(answer:'Ans 11',question_id: 1,school_id:1);
#Answer.create(answer:'Ans 12',question_id: 2,school_id:1);
#Answer.create(answer:'Ans 13',question_id: 3,school_id:1);
#Answer.create(answer:'Ans 21',question_id: 1,school_id:2);
#Answer.create(answer:'Ans 22',question_id: 2,school_id:2);
#Answer.create(answer:'Ans 23',question_id: 3,school_id:2);

#Loghistory.create(behavior:'1',answer:'AAAA',user_id: 4,question_id:1);
#Loghistory.create(behavior:'1',answer:'BBBB',user_id: 4,question_id:2);
#Loghistory.create(behavior:'1',answer:'CCCC',user_id: 4,question_id:3);
#Loghistory.create(behavior:'1',answer:'DDDD',user_id: 5,question_id:1);
#Loghistory.create(behavior:'1',answer:'EEEE',user_id: 5,question_id:2);
#Loghistory.create(behavior:'1',answer:'FFFF',user_id: 5,question_id:3);
#Loghistory.create(behavior:'1',answer:'GGGG',user_id: 3,question_id:1);
#Loghistory.create(behavior:'1',answer:'HHHH',user_id: 3,question_id:2);
#Loghistory.create(behavior:'1',answer:'IIII',user_id: 3,question_id:3);

#log = Loghistory.joins(:user).where(users: {'school_id': 1})
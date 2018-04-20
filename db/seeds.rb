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

#Question.create(title:'question 1',qtype:'dropdown',choice:'A,B',isrequire: true,musicin_id: 1);
#Question.create(title:'question 2',qtype:'text',isrequire: true,musicin_id: 1);
#Question.create(title:'question 3',qtype:'text',isrequire: true,musicin_id: 1);
#Question.create(title:'question 4',qtype:'radio',choice:'A,B',isrequire: true,musicin_id: 1);
#Question.create(title:'question 5',qtype:'radio',choice:'A,B',isrequire: true,musicin_id: 1);
#Question.create(title:'question 5',qtype:'radio',choice:'A,B',isrequire: false,musicin_id: 1);
#Question.create(title:'กระจับปี่',qtype:'text2',isrequire: true,musicin_id: 2);
#Question.create(title:'จะเข้',qtype:'text2',isrequire: true,musicin_id: 2);
#Question.create(title:'ซอด้วง',qtype:'text2',isrequire: true,musicin_id: 14);
#Question.create(title:'ซออู้',qtype:'text2',isrequire: true,musicin_id: 14);
#Question.create(title:'ซอสามสาย',qtype:'text2',isrequire: true,musicin_id: 14);
#Question.create(title:'teachercount',qtype:'text',musicin_id: 1);

#Question.create(title:'question 6',qtype:'radio',choice:'A,B');
#Question.create(title:'question 7',qtype:'radio',choice:'A,B');
#Question.create(title:'question 8',qtype:'radio',choice:'A,B');
#Question.create(title:'question 9',qtype:'radio',choice:'A,B');
#Question.create(title:'question 10',qtype:'radio',choice:'A,B');
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

#log = Loghistory.joins(:user).where(users: {'school_id': 1})Post.joins("LEFT OUTER JOIN answers ON answers.question_id = questions.id")
Teacherstatus.create({title:"ข้าราชการบำนาญ"})
Teacherstatus.create({title:"พนักงานราชการ"})
Teacherstatus.create({title:"ครูอัตราจ้าง"})
Teacherstatus.create({title:"ครูโครงการพิเศษ"})
Teacherstatus.create({title:"ปราชญ์ชาวบ้าน"})
Teacherposition.create({title:"ดนตรีศึกษา"})
Teacherposition.create({title:"ดนตรีไทย"})
Teacherposition.create({title:"ดนตรีสากล"})
Teacherposition.create({title:"ดุริยางคศิลป์"})
Teacherposition.create({title:"ดุริยางค์ไทย"})
Teacherposition.create({title:"ดนตรี/นาฏศิลป์"})
Teacheruniversity.create({title:"จุฬาลงกรณ์มหาวิทยาลัย"})
Teacheruniversity.create({title:"มหาวทิยาลัยมหิดล"})
Teacheruniversity.create({title:"มหาวิทยาลัยศิลปากร"})
Teacheruniversity.create({title:"มหาวิทยาลัยเกษตรศาสตร์"})
Teacheruniversity.create({title:"มหาวิทยาลัยศรีนครินวิโรฒ ประสานมิตร"})
Teacheruniversity.create({title:"มหาวิทยาลัยรามคำแหง"})
Teacheruniversity.create({title:"มหาวิทยาลัยขอนแก่น"})
Teacheruniversity.create({title:"มหาวิทยาลัยรังสิต"})
Teacheruniversity.create({title:"มหาวิทยาลัยอัสสัมชัญ"})
Teacheruniversity.create({title:"มหาวิทยาลัยบูรพา"})
Teacheruniversity.create({title:"มหาวิทยาลัยเทคโนโลยีราชมงคล"})
Teacheruniversity.create({title:"มหาวิทยาลัยพายัพ"})
Teacheruniversity.create({title:"มหาวิทยาลัยมหาสารคาม"})
Teacheruniversity.create({title:"มหาวิทยาลัยราชภัฏเชียงราย"})
Teacheruniversity.create({title:"มหาวิทยาลัยราชภัฏจันทรเกษม"})
Teacheruniversity.create({title:"มหาวิทยาลัยราชภัฏสมเด็จเจ้าพระยา"})
Teachertopic.create({title:"ดนตรีไทย"})
Teachertopic.create({title:"ดนตรีสากล"})
Teachertopic.create({title:"ดุริยางค์"})
Teachertopic.create({title:"ดนตรีพื้นบ้าน"})
#Musicin.create(title:"ครูดนตรี",formtype:1)
#Musicin.create(title:"เครื่องดีด และ เครื่องสี",formtype:2)
#Musicin.create(title:"เครื่องตี",formtype:2)
#Musicin.create(title:"เครื่องเป่า",formtype:2)
#Musicin.create(title:"เครื่องสาย",formtype:3)
#Musicin.create(title:"เครื่องตี",formtype:3)
#Musicin.create(title:"เครื่องประเภทลิ่มนิ้ว",formtype:3)
#Musicin.create(title:"เครื่องเป่าลมไม้",formtype:3)
#Musicin.create(title:"เครื่องเป่าทองเหลือง",formtype:3)
#Musicin.create(title:"ภาคเหนือ",formtype:4)
#Musicin.create(title:"ภาคอีสาน (เหนือ)",formtype:4)
#Musicin.create(title:"ภาคอีสาน (ใต้)",formtype:4)
#Musicin.create(title:"ภาคใต้",formtype:4)
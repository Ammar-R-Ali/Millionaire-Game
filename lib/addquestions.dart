// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:fluttercourse/sqldb.dart';

class AddQuestions extends StatefulWidget {
  final id;
  final question;
  final correctAnswer;
  final wrongAnswer1;
  final wrongAnswer2;
  final wrongAnswer3;
  const AddQuestions(
    {super.key, this.question, this.correctAnswer, this.wrongAnswer1, this.wrongAnswer2, this.wrongAnswer3, this.id});

  @override
  State<AddQuestions> createState() => _AddQuestions();
}

class _AddQuestions extends State<AddQuestions> {

SqlDb sqlDb = SqlDb();

  GlobalKey<FormState> formstate= GlobalKey();

  TextEditingController question = TextEditingController();
  TextEditingController correctAnswer = TextEditingController();
  TextEditingController wrongAnswer1 = TextEditingController();
  TextEditingController wrongAnswer2 = TextEditingController();
  TextEditingController wrongAnswer3 = TextEditingController();
  String ? level ="easy";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("إضافة الأسئلة"),
         titleTextStyle: const TextStyle(fontSize: 25,fontWeight: FontWeight.w700),
        backgroundColor: Colors.blue[700],
        leading:  IconButton(
        icon: const Icon(Icons.arrow_back_outlined),
        onPressed: () {Navigator.of(context).pushReplacementNamed("questionslist");})
        ),
      body: Container(
        color: Colors.blue[900],
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
        child: ListView(children: [
        const Center(child: Text("اختر مستوى صعوبة السؤال:",
         textDirection: TextDirection.rtl,
         style: TextStyle(color: Colors.white,fontSize: 25),)),
      Container(height: 10,),
      const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("سهل", style: TextStyle(color: Colors.white,fontSize: 20),),
          Text("متوسط", style: TextStyle(color: Colors.white,fontSize: 20),),
          Text("صعب", style: TextStyle(color: Colors.white,fontSize: 20),)
        ],
      ),
      Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
            Radio(activeColor: Colors.white, value: "easy", groupValue: level, onChanged:(val){setState(() {
              level=val;
            });}),
            Radio(activeColor: Colors.white,  value: "medium", groupValue: level, onChanged:(val){setState(() {
              level=val;
            });}),
            Radio(activeColor: Colors.white,  value: "hard", groupValue: level, onChanged:(val){setState(() {
              level=val;
            });}),
      ]),
        Form(
          key: formstate,
          child: Column(children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10,top: 20),
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),                     
              decoration: BoxDecoration(
              color: Colors.blue[700],
              border: Border.all(color: Colors.white,width: 2),
              borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                controller: question,
                maxLength: 100,
                style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 20),
                textDirection: TextDirection.rtl,
                decoration: const InputDecoration(
                  counterStyle: TextStyle(color: Colors.white,fontSize: 15),
                  hintText: "السؤال",
                  hintStyle: TextStyle(color: Color.fromARGB(255, 202, 198, 195),fontWeight: FontWeight.w700,fontSize: 20),
                  hintTextDirection: TextDirection.rtl,
                  focusedBorder:UnderlineInputBorder(borderSide: BorderSide(color: Colors.white),),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),                   
              decoration: BoxDecoration(
              color: Colors.blue[700],
              border: Border.all(color: Colors.white,width: 2),
              borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                controller: correctAnswer,
                maxLength: 25,
                style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 20),
                textDirection: TextDirection.rtl,
                decoration: const InputDecoration(
                  counterStyle: TextStyle(color: Colors.white,fontSize: 15),
                  hintText: "الجواب الصحيح",
                  hintStyle: TextStyle(color: Color.fromARGB(255, 202, 198, 195),fontWeight: FontWeight.w700,fontSize: 20),
                  hintTextDirection: TextDirection.rtl,
                  focusedBorder:UnderlineInputBorder(borderSide: BorderSide(color: Colors.white),),
              )),
            ),
            Container( 
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),                         
              decoration: BoxDecoration(
              color: Colors.blue[700],
              border: Border.all(color: Colors.white,width: 2),
              borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                controller: wrongAnswer1,
                maxLength: 25,
                style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 20),
                textDirection: TextDirection.rtl,
                decoration: const InputDecoration(
                  counterStyle: TextStyle(color: Colors.white,fontSize: 15),
                  hintText: "إجابة خاطئة 1",
                  hintStyle: TextStyle(color: Color.fromARGB(255, 202, 198, 195),fontWeight: FontWeight.w700,fontSize: 20),
                  hintTextDirection: TextDirection.rtl,
                  focusedBorder:UnderlineInputBorder(borderSide: BorderSide(color: Colors.white),),)
              ),
            ),
             Container(
             margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
              decoration: BoxDecoration(
              color: Colors.blue[700],
              border: Border.all(color: Colors.white,width: 2),
              borderRadius: BorderRadius.circular(15)),
               child: TextFormField(
                controller: wrongAnswer2,
                maxLength: 25,
                style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 20),
                textDirection: TextDirection.rtl,
                decoration: const InputDecoration(
                  counterStyle: TextStyle(color: Colors.white,fontSize: 15),
                  hintText: "إجابة خاطئة 2",
                  hintStyle: TextStyle(color: Color.fromARGB(255, 202, 198, 195),fontWeight: FontWeight.w700,fontSize: 20),
                  hintTextDirection: TextDirection.rtl,
                  focusedBorder:UnderlineInputBorder(borderSide: BorderSide(color: Colors.white),),)
                         ),
             ),
             Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),                 
              decoration: BoxDecoration(
              color: Colors.blue[700],
              border: Border.all(color: Colors.white,width: 2),
              borderRadius: BorderRadius.circular(15)),
               child: TextFormField(
                controller: wrongAnswer3,
                maxLength: 25,
                style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 20),
                textDirection: TextDirection.rtl,
                decoration: const InputDecoration(
                  counterStyle: TextStyle(color: Colors.white,fontSize: 15),
                  hintText: "إجابة خاطئة 3",
                     hintStyle: TextStyle(color: Color.fromARGB(255, 202, 198, 195),fontWeight: FontWeight.w700,fontSize: 20),
                    hintTextDirection: TextDirection.rtl,
                    focusedBorder:UnderlineInputBorder(borderSide: BorderSide(color: Colors.white),),)
                         ),
             ),
            Container(
              margin: const EdgeInsets.all(10),
              height: 50,
              child: MaterialButton(
                color: Colors.blue[700],
                minWidth: 200,
                height: 50,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  side:  const BorderSide(color: Colors.white,width:2),
                  borderRadius: BorderRadius.circular(30)),
                onPressed: ()async{
                int ? response;
                if(level=="easy"){
                   response = await sqlDb.insert("easyQuestions",{
                   "question":question.text ,
                   "answerT":correctAnswer.text,
                   "answer1F":wrongAnswer1.text,
                   "answer2F":wrongAnswer2.text,
                   "answer3F":wrongAnswer3.text,
                });}
                else if(level=="medium"){
                   response = await sqlDb.insert("mediumQuestions",{
                   "question":question.text ,
                   "answerT":correctAnswer.text,
                   "answer1F":wrongAnswer1.text,
                   "answer2F":wrongAnswer2.text,
                   "answer3F":wrongAnswer3.text,
                });}
                else{
                  response = await sqlDb.insert("hardQuestions",{
                   "question":question.text ,
                   "answerT":correctAnswer.text,
                   "answer1F":wrongAnswer1.text,
                   "answer2F":wrongAnswer2.text,
                   "answer3F":wrongAnswer3.text,
                });}

                 if(response > 0){
                 // ignore: use_build_context_synchronously
                 Navigator.of(context).pushReplacementNamed("questionslist");
                 }

                },
                child: const Text("إضافة السؤال",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25))),)
        ],))
      ],),),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttercourse/sqldb.dart';
import 'package:fluttercourse/insertname.dart';
class GamePage  extends StatefulWidget {
  const GamePage({Key? key}):super(key: key);
  @override
  State<GamePage> createState()=> _GamePage();}
  class  _GamePage extends State<GamePage>{

  SqlDb sqlDb = SqlDb();
  bool changeQuestion=true; //إمكانية تغيير السؤال
  bool delete2Answers=true;//إمكانية حذف إجابتين
  List<Map> gameQuestions = List.generate(16, (index) => {}); //أسئلة المسابقة
  List questions1 =[]; //مصفوفة لجميع الأسئلة السهلة ضمن قاعدة البيانات
  List questions2 =[];//مصفوفة لجميع الأسئلة المتوسطة ضمن قاعدة البيانات
  List questions3 =[];//مصفوفة لجميع الأسئلة الصعبة ضمن قاعدة البيانات
  int questionNum =0;//رقم السؤال
  int money=0;//مقدار الربح
  List answers=List.generate(4, (index) => '');//مصفوفة للأجوبة لكل سؤال

//ألوان الأزرار الافتراضية
  Color? answer0Color=Colors.blue[700];
  Color? answer1Color=Colors.blue[700];
  Color? answer2Color=Colors.blue[700];
  Color? answer3Color=Colors.blue[700];
  Color? changeQuestionColor=Colors.blue[700];
  Color? delete2AnswersColor=Colors.blue[700];

  List disabledAnswersIndex = List.generate(2, (index) => -1);//أزرار الأجوبة المعطلة عند حذف إجابتين

//استدعاء جميع الأسئلة من قاعدة البيانات ووضعها في مصفوفات
  Future readData1() async{
    List<Map> response1 = await sqlDb.read("easyQuestions");
    questions1.addAll(response1);
    if(mounted){//تكون true فقط بعد استعداء الحالة الابتدائية مباشرة
      setState(() {
        
      });
    }
    return response1 ;
  }
  Future readData2() async{
    List<Map> response2 = await sqlDb.read("mediumQuestions");
    questions2.addAll(response2);
    if(mounted){
      setState(() {
        
      });
    }
    return response2;
  }
  Future readData3() async{
    List<Map> response3= await sqlDb.read("hardQuestions");
    questions3.addAll(response3);
    if(mounted){
      setState(() {

      });
    }
    setQuestions();//وضع أسئلة المسابقة
    setAnswers();//وضع أجوبة السؤال الأول
    return response3;
  }


Random random = Random();
  Set<int> generatedNumbers1 = <int>{};//مجموعة الأرقام العشوائية الخاصة بالأسئلة السهلة
  Set<int> generatedNumbers2 = <int>{};//مجموعة الأرقام العشوائية الخاصة بالأسئلة المتوسطة
  Set<int> generatedNumbers3 = <int>{};//مجموعة الأرقام العشوائية الخاصة بالأسئلة الصعبة

//وضع اسئلة المسابقة
void setQuestions() {
  for (int i = 0; i < 5; i++) {
    int randomNumber1;
    int randomNumber2;
    int randomNumber3;

    do {
      randomNumber1 = random.nextInt(questions1.length);
    } while (generatedNumbers1.contains(randomNumber1));
    generatedNumbers1.add(randomNumber1);

    do {
      randomNumber2 = random.nextInt(questions2.length);
    } while (generatedNumbers2.contains(randomNumber2));
    generatedNumbers2.add(randomNumber2);

    do {
      randomNumber3 = random.nextInt(questions3.length);
    } while (generatedNumbers3.contains(randomNumber3));
    generatedNumbers3.add(randomNumber3);

    gameQuestions[i] = questions1[randomNumber1];//الأسئلة السهلة
    gameQuestions[i + 5] = questions2[randomNumber2];//الأسئلة المتوسطة
    gameQuestions[i + 10] = questions3[randomNumber3];//الأسئلة الصعبة
  }
  
  int randomNumberAlternative;// رقم عشوائي من أجل السؤال البديل
  do {
    randomNumberAlternative = random.nextInt(questions3.length);
  } while (generatedNumbers3.contains(randomNumberAlternative)); // التأكد من عدم تكرار السؤال البديل
  gameQuestions[15] = questions3[randomNumberAlternative]; // السؤال الصعب البديل
}

setAnswers(){
  answers[0]= "${gameQuestions[questionNum]['answerT']}";
  answers[1]= "${gameQuestions[questionNum]['answer1F']}";
  answers[2]= "${gameQuestions[questionNum]['answer2F']}";
  answers[3]= "${gameQuestions[questionNum]['answer3F']}";
  answers.shuffle();
  //إعادة تفعيل أزرار الإجابة
  disabledAnswersIndex[0]=-1;disabledAnswersIndex[1]=-1;
}

int getMoney(){
  switch(questionNum){
    case 1: money=100;
    case 2: money=200;
    case 3: money=300;
    case 4: money=500;
    case 5: money=1000;
    case 6: money=2000;
    case 7: money=4000;
    case 8: money=8000;
    case 9: money=16000;
    case 10: money=32000;
    case 11: money=64000;
    case 12: money=128000;
    case 13: money=250000;
    case 14: money=500000;
    case 15: money=100000;
    default: money=0;}
    return money;
}

void showRightAnswer(){setState((){
    if(answers[0]==gameQuestions[questionNum]['answerT']){ answer0Color=Colors.green[700];}
    else if(answers[1]==gameQuestions[questionNum]['answerT']){ answer1Color=Colors.green[700];}
    else if(answers[2]==gameQuestions[questionNum]['answerT']){ answer2Color=Colors.green[700];}
    else if(answers[3]==gameQuestions[questionNum]['answerT']){ answer3Color=Colors.green[700];}});}


 winning() async {
   int ? response= await sqlDb.insert("players",{
    "f_name":"$firstName" ,
    "l_name":"$lastName",
    "gain":"${1000000}",});
   if(response > 0){
    gain=1000000;
    Navigator.of(context).pushReplacementNamed("win");
  }}

 losing() async {
   int ? response= await sqlDb.insert("players",{
    "f_name":"$firstName" ,
    "l_name":"$lastName",
    "gain":"${getMoney()}",});
   if(response > 0 ){
    gain=getMoney();
    Navigator.of(context).pushReplacementNamed("lose");
  }}
  bool wrongTapped =false; //الضغط على زر إجابة خاطىء
  bool buttonTapped =false;//الضغط على زر إجابة
  void handleButtonTap(){ //منع الضغط على الزر لمدة ثانية
    setState(() {
      Timer(const Duration(seconds: 1), () {
        setState(() {
          buttonTapped=false;
        });
       });
    });
  }

//الحالة الابتدائية
@override
void initState() {
  super.initState(); 
  readData1();
  readData2();
  readData3();

}
  @override
  Widget build(BuildContext context) {
    return WillPopScope( //لمنع الانتقال إلى الشاشة السابقة عند الضغط على زر الرجوع
      onWillPop: () async {
        // إظهار رسالة تأكيد عند الضغط على زر الرجوع
        showDialog(
          context: context,
          builder: (context) =>  AlertDialog( //رسالة التنبيه
            title: const Text("هل تريد الخروج؟",textAlign: TextAlign.center,),
            titlePadding: const EdgeInsets.all(10),
            titleTextStyle: const TextStyle(fontSize: 25,),
            content: const Text("سوف تخسر تقدمك في المسابقة في حال خروجك",textAlign: TextAlign.center,),
            contentPadding: const EdgeInsets.all(10),
            contentTextStyle: const TextStyle(fontSize: 20),
            backgroundColor: Colors.blue[700],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            actions: [
              MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                color: Colors.green,
                onPressed: (){Navigator.of(context).pop();},
                child: const Text("لا",style: TextStyle(fontSize: 20,color: Colors.white),)),
              MaterialButton(
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
               color: Colors.red,
               onPressed: (){
                   Navigator.of(context).pushNamedAndRemoveUntil("home",(route)=>false);},
               child: const Text("نعم",style: TextStyle(fontSize: 20,color: Colors.white),)),],
           )
        );
        return false;// يمنع العودة إلى الوراء
      },
      child: Scaffold(
        body:Container(
          color: Colors.blue[900],
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
          child: Column(children: [
            // بداية سطر ===========================================================================================================================  
          
            Expanded(child: Row(children: [
              Column( 
                children: [
                  //--------------------------------------------------------------------------------------------------------------------------
                  //زر الخروج من المسابقة
                  Container(
                    margin: const EdgeInsets.only(right: 10,top: 10),
                    decoration: BoxDecoration(
                      border:Border.all(color: Colors.white,),
                      color:Colors.blue[700],
                      borderRadius: BorderRadius.circular(40)),
                    child: IconButton(
                      onPressed: (){
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context){
                          return AlertDialog( //رسالة التنبيه
                            title: const Text("هل تريد الخروج؟",textAlign: TextAlign.center,),
                            titlePadding: const EdgeInsets.all(10),
                            titleTextStyle: const TextStyle(fontSize: 25,),
                            content: const Text("سوف تخسر تقدمك في المسابقة في حال خروجك",textAlign: TextAlign.center,),
                            contentPadding: const EdgeInsets.all(10),
                            contentTextStyle: const TextStyle(fontSize: 20),
                            backgroundColor: Colors.blue[700],
                            //icon: Icon(Icons.warning),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                            actionsAlignment: MainAxisAlignment.spaceEvenly,
                            actions: [
                              MaterialButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                color: Colors.green,
                                onPressed: (){Navigator.of(context).pop();},
                                child: const Text("لا",style: TextStyle(fontSize: 20,color: Colors.white),)),
                              MaterialButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                color: Colors.red,
                                onPressed: (){
                                  Navigator.of(context).pushNamedAndRemoveUntil("home",(route)=>false);},
                                child: const Text("نعم",style: TextStyle(fontSize: 20,color: Colors.white),)),],
                            );
                          }
                        );
                      },
                      icon: const Icon(Icons.exit_to_app_rounded,color: Colors.white,size:30,))),
                     Container(margin: const EdgeInsets.only(right: 10), child: const Text("الخروج",  style: TextStyle(color: Colors.white),))
                ],
              ),
              //--------------------------------------------------------------------------------------------------------------------------------

              //زر إعادة اللعب
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10,top: 10),
                    decoration: BoxDecoration(
                      border:Border.all(color: Colors.white,),
                      color:Colors.blue[700],
                      borderRadius: BorderRadius.circular(40)),
                   child: IconButton(
                      onPressed: (){
                         showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context){
                          return AlertDialog( //رسالة التنبيه
                            title: const Text("هل تريد إعادة اللعب؟",textAlign: TextAlign.center,),
                            titlePadding: const EdgeInsets.all(10),
                            titleTextStyle: const TextStyle(fontSize: 25,),
                            content: const Text("ستبقى معلومات المتسابق المدخلة نفسها ولكنك ستعود إلى نقطة البداية",textAlign: TextAlign.center,),
                            contentPadding: const EdgeInsets.all(10),
                            contentTextStyle: const TextStyle(fontSize: 20),
                            backgroundColor: Colors.blue[700],
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                            actionsAlignment: MainAxisAlignment.spaceEvenly,
                            actions: [
                              MaterialButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                color: Colors.green,
                                onPressed: (){Navigator.of(context).pop();},
                                child: const Text("لا",style: TextStyle(fontSize: 20,color: Colors.white),)),
                              MaterialButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                color: Colors.red,
                                onPressed: (){
                                  Navigator.of(context).pushReplacementNamed("game");},
                                child: const Text("نعم",style: TextStyle(fontSize: 20,color: Colors.white),)),],
                            );
                          }
                        );
                      },
                      icon:const Icon(Icons.restart_alt_rounded,color: Colors.white,size:30,))),
                      Container( margin: const EdgeInsets.only(right: 10), child: const Text("إعادة اللعب",  style: TextStyle(color: Colors.white),))
                ],
              ),
              //---------------------------------------------------------------------------------------------------------------------------
              const Spacer(),//فراغ
              //---------------------------------------------------------------------------------------------------------------------------

              //تحديد المستوى الحالي
              Column(
                children: [
                  Container(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    child:  Text("المستوى: ${(questionNum<5)? "سهل":(questionNum<10)?"متوسط":"صعب"}"
                    ,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 25),),),
                   Text("${questionNum+1}/15",style: const TextStyle(color: Colors.white,fontSize: 20),)
                ],
              )
              //-------------------------------------------------------------------------------------------------------------------------------

            ],)),
           //انتهى السطر======================================================================================================================================
           
           //حاوية نص السؤال
            Expanded(flex: 3,
            child: Container( 
              margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
              decoration: BoxDecoration(
                color: Colors.blue[700],
                border: Border.all(color: Colors.white,width: 2),
                borderRadius: BorderRadius.circular(45)),
                
              alignment: Alignment.center,
              width:500,
            
              padding:const  EdgeInsets.all(5),
              child:  Text("${ gameQuestions[questionNum]['question']}",
              style: const TextStyle(color: Colors.white,fontSize: 25),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,),
            )),
            //--------------------------------------------------------------------------------------------------------------------------------

           //بداية سطر ====================================================================================================================================
            Expanded(child: Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,children: [

               //زر حذف إجابتين
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                      border:Border.all(color: Colors.white,),
                      color:delete2AnswersColor,
                      borderRadius: BorderRadius.circular(30)),
                    child: IconButton(
                      onPressed: (){
                        setState(() {
                          int i=0;//عداد للتأكد من حذف إجابتين فقط
                        if(delete2Answers){
                          int lastIndex=-1;//للإشارة إلى أخر جواب محذوف
                          int a=0;//عداد لمصفوفة الاجوبة المعطلة
                          while(i<2){
                            int randomIndex=random.nextInt(3);
                            if(answers[randomIndex]!=gameQuestions[questionNum]['answerT']&& randomIndex!=lastIndex){
                              answers[randomIndex]='';
                              i++;
                              lastIndex=randomIndex;
                              disabledAnswersIndex[a]=randomIndex;a++;}}
                          delete2AnswersColor=Colors.grey[700];// تلوين زر حذف إجابتين بالرمادي
                          delete2Answers=false;// عدم إمكانية حذف إجابتين مرة أخرى
                          }
                          });
                         
                      },
                      icon: const Text("50:50",style: TextStyle(fontSize: 12,color: Colors.white),))),
                  const Text("حذف إجابتين",style: TextStyle(color: Colors.white),)
                ],
              ),
              //-----------------------------------------------------------------------------------------------------------------------------

              //حاوية كمية الريح
              Container( 
              margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              decoration: BoxDecoration(
              color: Colors.blue[700],
              border: Border.all(color: Colors.white,width: 2),
              borderRadius: BorderRadius.circular(20)),   
              alignment: Alignment.center,
              width:200,
              padding:const  EdgeInsets.all(5),
              child:  Text("${getMoney()}\$",
               style: const TextStyle(color: Colors.white,fontSize: 20),
              textDirection: TextDirection.rtl,)
              ,
            ),
            //--------------------------------------------------------------------------------------------------------------------------------

            //زر تغيير السؤال
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                      border:Border.all(color: Colors.white,),
                      color:changeQuestionColor,
                      borderRadius: BorderRadius.circular(40)),
                   child: IconButton(
                    onPressed:(){
                      setState(() {
                         if(questionNum<10){
                          showDialog(
                          context: context,
                          builder: (context){
                          return AlertDialog( //رسالة التنبيه
                            content: const Text("لا يمكنك استخدام وسيلة المساعدة هذه قبل الوصول إلى المستوى الصعب",textAlign: TextAlign.center,),
                            contentPadding: const EdgeInsets.all(20),
                            contentTextStyle: const TextStyle(fontSize: 20),
                            backgroundColor: Colors.blue[700],
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            );
                          }
                        );
                         }
                        else if(questionNum>=10 && changeQuestion){
                          setState(() {
                          gameQuestions[questionNum]=gameQuestions[15];//تبديل السؤال الحالي بالسؤال البديل
                          setAnswers();//وضع إجابات السؤال البديل
                          changeQuestion=false;//عدم إمكانية تغيير السؤال مرة أخرى
                          changeQuestionColor=Colors.grey[700];// تلوين زر تغيير السؤال بالرمادي
                          });}
                        else{null;}
                      });
                     
                    },
                      icon:const Icon(Icons.change_circle_outlined,color: Colors.white,size:30,))),
                   const Text("تغيير السؤال",style: TextStyle(color: Colors.white),)
                ],
              ),
              //-------------------------------------------------------------------------------------------------------------------------------
            ],)),
            //انتهى السطر=========================================================================================================================

            Expanded(flex:4,child:Column(
              mainAxisAlignment:MainAxisAlignment.spaceEvenly, children: [

                 //زر الإجابة الأولى
                MaterialButton(
                onPressed: (buttonTapped || wrongTapped)?handleButtonTap:(){// التحقق من أن الزر تم ضغطه أم لا 
                  if(disabledAnswersIndex[0]!=0 && disabledAnswersIndex[1]!=0){//التأكد من أن زر الإجابة غير معطل
                  setState(() {
                  if(answers[0]==gameQuestions[questionNum]['answerT']){//الإجابة صحيحة
                    showRightAnswer();
                    buttonTapped=true;
                    Future.delayed(const Duration(seconds: 1),(){
                    setState(() { 
                    if(questionNum<14){//السؤال ليس الأخبر
                    answer0Color=Colors.blue[700];
                    questionNum++;//الانتقال الى السؤال التالي
                    setAnswers();//عرض أجوبة السؤال التالي
                    buttonTapped=false;}
                    else{winning();}});//عند السؤال الأخير
                    });}
                  else{//الإجابة خاطئة
                     answer0Color=Colors.red[700];
                     wrongTapped=true;
                     Future.delayed(const Duration(seconds: 1),(){showRightAnswer();});
                     Future.delayed(const Duration(seconds: 2),(){losing();});
                  } });
                  }
                  },
                color:answer0Color,
                textColor: Colors.white,
                height: 70,minWidth:380,
                shape: RoundedRectangleBorder(
                  side:const BorderSide(color: Colors.white,width:2),
                  borderRadius: BorderRadius.circular(30)),
                child: Text("${answers[0]}",
               style: const TextStyle(color: Colors.white,fontSize: 25),
                 textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                ),
                 ),

                //-------------------------------------------------------------------------------------------------------------------------
                //زر الإجابة الثانية
                 MaterialButton(
                  onPressed: (buttonTapped || wrongTapped)?handleButtonTap: (){
                  if(disabledAnswersIndex[0]!=1 && disabledAnswersIndex[1]!=1){
                  setState(() {
                  if(answers[1]==gameQuestions[questionNum]['answerT']){
                    showRightAnswer();
                    buttonTapped=true;
                    Future.delayed(const Duration(seconds: 1),(){
                    setState(() { 
                    if(questionNum<14){
                      answer1Color=Colors.blue[700];
                      questionNum++;
                      setAnswers();
                      buttonTapped=false;}
                    else{winning();}});
                    });}
                  else{
                     answer1Color=Colors.red[700];
                     wrongTapped=true;
                     Future.delayed(const Duration(seconds: 1),(){showRightAnswer();});
                     Future.delayed(const Duration(seconds: 2),(){losing();});
                  } });
                  }
                  },
                color: answer1Color,
                textColor: Colors.white,
                height: 70,minWidth:380,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.white,width:2),
                  borderRadius: BorderRadius.circular(30)),
                child: Text("${answers[1]}",
                 style: const TextStyle(color: Colors.white,fontSize: 25),
                 textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,),
                 ),

                 //-------------------------------------------------------------------------------------------------------------------------
                 //زر الإجابة الثالثة
                 MaterialButton(
                  onPressed: (buttonTapped || wrongTapped)?handleButtonTap: (){
                  if(disabledAnswersIndex[0]!=2 && disabledAnswersIndex[1]!=2){
                  setState(() {
                  if(answers[2]==gameQuestions[questionNum]['answerT']){
                    showRightAnswer();
                    buttonTapped=true;
                    Future.delayed(const Duration(seconds: 1),(){
                    setState(() { 
                    if(questionNum<14){
                      answer2Color=Colors.blue[700];
                      questionNum++;
                      setAnswers();
                      buttonTapped=false;}
                    else{winning();}});
                    });}
                  else{
                     answer2Color=Colors.red[700];
                     wrongTapped=true;
                     Future.delayed(const Duration(seconds: 1),(){showRightAnswer();});
                     Future.delayed(const Duration(seconds: 2),(){losing();});
                  } });
                  }
                   },
                color: answer2Color,
                textColor: Colors.white,
                height: 70,minWidth:380,
                shape: RoundedRectangleBorder(
                  side:const BorderSide(color: Colors.white,width:2),
                  borderRadius: BorderRadius.circular(30)),
                child: Text("${answers[2]}",
                 style: const TextStyle(color: Colors.white,fontSize: 25),
                 textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,),
                 ),

                 //-------------------------------------------------------------------------------------------------------------------------
                 //زر الإجابة الرابعة
                 MaterialButton( 
                  onPressed: (buttonTapped || wrongTapped)?handleButtonTap: (){
                  if(disabledAnswersIndex[0]!=3 && disabledAnswersIndex[1]!=3){
                  setState(() {
                  if(answers[3]==gameQuestions[questionNum]['answerT']){
                    showRightAnswer();
                    buttonTapped=true;
                    Future.delayed(const Duration(seconds: 1),(){
                    setState(() {
                    if(questionNum<14){
                      answer3Color=Colors.blue[700];
                      questionNum++;
                      setAnswers();
                      buttonTapped=false;}
                    else {winning();}});
                  });}
                  else{
                     answer3Color=Colors.red[700];
                     wrongTapped=true;
                     Future.delayed(const Duration(seconds: 1),(){showRightAnswer();});
                     Future.delayed(const Duration(seconds: 2),(){losing();});
                  } });
                  }
                  },
                color:  answer3Color,
                textColor: Colors.white,
                height: 70,minWidth:380,
                shape: RoundedRectangleBorder(
                  side:  const BorderSide(color: Colors.white,width:2),
                  borderRadius: BorderRadius.circular(30)),
                child: Text("${answers[3]}",
                 style: const TextStyle(color: Colors.white,fontSize: 25),
                 textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,),
                 ),]
              )
            )
              
            ]
            )
            
          
          ),
          
       )
    );
   }
  }
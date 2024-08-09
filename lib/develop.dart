import 'package:flutter/material.dart';
import 'package:fluttercourse/sqldb.dart';

class Develop extends StatefulWidget {
  const Develop({super.key});


  @override
  State<Develop> createState() => _DevelopState();
}

class _DevelopState extends State<Develop> {
SqlDb sqlDb = SqlDb();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // عند الضغط على زر الرجوع، انتقل إلى الصفحة الرئيسية
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
        return false; // هذا يمنع الخروج الافتراضي
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("خيارت المطور"),
       backgroundColor: Colors.blue[700],
       titleTextStyle: const TextStyle(fontSize: 25,fontWeight: FontWeight.w700),
       leading:  IconButton(
        icon: const Icon(Icons.arrow_back_outlined),
        onPressed: () {Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
       },)),
      body: Container(
        padding:const EdgeInsets.all(10),
        color: Colors.blue[900],
        child: ListView(
          children: [
          const Center(child: Text("خيارت التعديل على بيانات اللعبة:",
            textDirection: TextDirection.rtl,
            style: TextStyle(fontSize: 30,color: Colors.white),)),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: MaterialButton(
              onPressed: (){Navigator.of(context).pushNamed("questionslist");}, 
              minWidth: 300,height: 50,
              color: Colors.blue[700],
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
              side:  const BorderSide(color: Colors.white,width:2),
              borderRadius: BorderRadius.circular(30)),
              child: const Text("عرض قائمة الأسئلة",style: TextStyle(fontSize: 25),),),
          ),


           Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
             child: MaterialButton(
            onPressed: (){
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context){
                          return AlertDialog( //رسالة التنبيه
                            title: const Text("هل تريد بالتأكيد إعادة ضبط قاعدة البيانات؟",textAlign: TextAlign.center,),
                            titlePadding: const EdgeInsets.all(10),
                            titleTextStyle: const TextStyle(fontSize: 25,),
                            icon: const Icon(Icons.warning,color: Colors.yellow,),
                            content: const Text("سوف يتم حذف بيانات اللاعبين والأسئلة المضافة بشكل نهائي والعودة إلى قاعدة البيانات الافتراضية ",textAlign: TextAlign.center,),
                            contentPadding: const EdgeInsets.all(10),
                            contentTextStyle: const TextStyle(fontSize: 20,),
                            backgroundColor: Colors.red[800],
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
                                onPressed: ()async{
                                   // ignore: use_build_context_synchronously
                                   await sqlDb.resetDatabase();Navigator.of(context).pop();},
                                child: const Text("نعم",style: TextStyle(fontSize: 20,color: Colors.white),)),],
                            );
                          }
                        );
                      }, 
              minWidth: 300,height: 50,
              color: Colors.red,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
              side:  const BorderSide(color: Colors.white,width:2),
              borderRadius: BorderRadius.circular(30)),
              child: const Text("إعادة ضبط قاعدة البيانات ",style: TextStyle(fontSize: 25),),),
           ),
      ],),),
    ));
  }
}
import 'package:flutter/material.dart';
import 'package:fluttercourse/sqldb.dart';
class InsertName extends StatefulWidget {
 
  const InsertName({Key? key}):super(key: key);
  @override
  State<InsertName> createState()=> _InsertName();}
  String ? firstName;
  String ? lastName;
  int ? gain;

   class _InsertName extends State<InsertName>{
    GlobalKey<FormState> formstate =GlobalKey();
   SqlDb sqlDb = SqlDb();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
             appBar: AppBar(
              backgroundColor: Colors.blue[700],
              leading:  IconButton(icon: const Icon(Icons.arrow_back_outlined),onPressed: () {Navigator.of(context).pop();
              },)),
             body:Container(
              padding:const EdgeInsets.all(10),
              color: Colors.blue[900],
              child: Form(
                key: formstate,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  const Center(child: Text("يُرجى إدخال اسمك أولاً:",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize:30,color: Colors.white),)),
                   Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                    color: Colors.blue[700],
                    border: Border.all(color: Colors.white,width: 2),
                    borderRadius: BorderRadius.circular(15)),
                    child: TextFormField(
                      onSaved: (newValue) {
                        firstName=newValue; },
                      style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 20),
                      decoration: InputDecoration(
                        hintText: "الاسم الأول",
                        hintStyle: const TextStyle(color: Color.fromARGB(255, 202, 198, 195),fontWeight: FontWeight.w700,fontSize: 20),
                        hintTextDirection: TextDirection.rtl,
                        focusedBorder:const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white),),
                        errorStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18),
                        errorBorder: UnderlineInputBorder(borderSide: BorderSide(width:2,color: Colors.red[500]!),)),
                        textDirection: TextDirection.rtl,
                        keyboardType: TextInputType.name,
                      validator: (value){
                        if(value!.isEmpty) return "الحقل فارغ";
                        if(value.length>10) return "الاسم المُدخل طويل جداً يرجى تعديله";
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 40,top: 20),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                    color: Colors.blue[700],
                    border: Border.all(color: Colors.white,width: 2),
                    borderRadius: BorderRadius.circular(15)),
                    child: TextFormField(
                      onSaved: (newValue) {
                        lastName=newValue;
                      },
                      style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 20),
                      decoration: InputDecoration(
                        hintText: "الاسم الثاني (اسم العائلة)",
                        hintStyle: const TextStyle(color: Color.fromARGB(255, 202, 198, 195),fontWeight: FontWeight.w700,fontSize: 20),
                        hintTextDirection: TextDirection.rtl,
                        focusedBorder:const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white),),
                        errorStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18),
                        errorBorder: UnderlineInputBorder(borderSide: BorderSide(width:2,color: Colors.red[500]!),)),
                        textDirection: TextDirection.rtl,
                        keyboardType: TextInputType.name,
                      validator: (value){
                        if(value!.isEmpty) return "الحقل فارغ";
                        if(value.length>20) return "الاسم المُدخل طويل جداً يرجى تعديله";
                        return null;
                      },
                    ),
                  ),
                  Center(
                    child:MaterialButton(
                      color: Colors.blue[700],
                      minWidth: 200,
                      height: 50,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        side:  const BorderSide(color: Colors.white,width:2),
                        borderRadius: BorderRadius.circular(30)),
                      onPressed: (){
                        if(formstate.currentState!.validate()){
                          formstate.currentState!.save();
                         Navigator.of(context).pushNamed("game");
                        }
                        },
                      child: const Text("إبدأ اللعبة",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25),)),
                  ),
                ]),
              ),
             )
    ));
   }
  }
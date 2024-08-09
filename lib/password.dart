import 'package:flutter/material.dart';
class PassWord extends StatefulWidget {
 
  const PassWord({Key? key}):super(key: key);
  @override
  State<PassWord> createState()=> _PassWord();}
  String password="Ammar2003";

   class _PassWord extends State<PassWord>{
    GlobalKey<FormState> formstate =GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
             appBar: AppBar(title: const Text("خيارت المطور"),
             titleTextStyle: const TextStyle(fontSize: 25,fontWeight: FontWeight.w700),
             leading:  IconButton(icon: const Icon(Icons.arrow_back_outlined),onPressed: () {Navigator.of(context).pop();
              },)),
             body:Container(
              padding:const EdgeInsets.all(10),
              color: Colors.blue[900],
              child: Form(
                key: formstate,
                child: Column(
                  children: [
                  const Center(child: Text("هذه الصفحة مخصصة لمطوري اللعبة",
                   textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize:26,color: Colors.white,),
                  )),
                  const Center(child: Text("يُرجى إدخال كلمة المرور للدخول:",
                   textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize:25,color: Colors.white),)),
                   Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                    color: Colors.blue[700],
                    border: Border.all(color: Colors.white,width: 2),
                    borderRadius: BorderRadius.circular(15)),
                    child: TextFormField(
                      obscureText: true,
                      style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 20),
                      decoration: InputDecoration(
                        prefix: const Icon(Icons.lock,color: Colors.white,size: 30,),
                        hintText: "كلمة المرور",
                        hintStyle: const TextStyle(color: Color.fromARGB(255, 202, 198, 195),fontWeight: FontWeight.w700,fontSize: 20),
                        hintTextDirection: TextDirection.rtl,
                        focusedBorder:const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white),),
                        errorStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18),
                        errorBorder: UnderlineInputBorder(borderSide: BorderSide(width:2,color: Colors.red[500]!),)),
                        textDirection: TextDirection.rtl,
                        keyboardType: TextInputType.name,
                      validator: (value){
                        if(value!.isEmpty) return "الحقل فارغ";
                        if(value!=password) return "كلمةالمرور خاطئة";
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
                         Navigator.of(context).pushNamed("develop");
                        }
                        },
                      child: const Text("موافق",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25),)),
                  ),
                ]),
              ),
             )
    ));
   }
  }
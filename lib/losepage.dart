import 'package:flutter/material.dart';
import 'package:fluttercourse/insertname.dart';
class LosePage extends StatefulWidget {
  
  const LosePage({Key? key}):super(key: key);
  @override
  State<LosePage> createState()=> _LostState();}

   class _LostState extends State<LosePage>{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
             body:Container(    
              color: Colors.blue[900],
              child: ListView(
                children: [
                const Center(child:
                    Text("لقد خسرت!",
                    textDirection:TextDirection.rtl,
                    style: TextStyle(fontSize: 50,color:Colors.white)),
                ),
                   Center(
                    child: Text("لا بأس يا $firstName لقد حصلت على $gain\$ ",
                    textDirection:TextDirection.rtl,
                    style: const TextStyle(fontSize: 20,color: Colors.white),
                    ),
                  ),
                const Center(child: Text("حظاً أوفر في المرة القادمة",
                textDirection:TextDirection.rtl,
                style: TextStyle(fontSize: 40,color: Color.fromARGB(255, 247, 222, 1)),)),
                Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  height: 400,
                  width: 400,
                  child: Image.asset("images/try again.jpg",fit: BoxFit.fill,)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                      MaterialButton(
                      color: Colors.blue[700],
                      textColor: Colors.white,
                      height: 50,minWidth:170,
                      shape: RoundedRectangleBorder(
                        side:  const BorderSide(color: Colors.white,width:2),
                        borderRadius: BorderRadius.circular(30)),
                      onPressed: (){Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);},
                      child: const Row(
                        children: [
                          Icon(Icons.exit_to_app_rounded),
                          Text("  الخروج",style: TextStyle(fontSize: 20),)
                        ],
                      ),),
                      MaterialButton(
                      color: Colors.blue[700],
                      textColor: Colors.white,
                      height: 50,minWidth:170,
                      shape: RoundedRectangleBorder(
                        side:  const BorderSide(color: Colors.white,width:2),
                        borderRadius: BorderRadius.circular(30)),
                      onPressed: (){Navigator.of(context).pushReplacementNamed("game");},
                      child: const Row(
                        children: [
                          Icon(Icons.restart_alt_rounded),
                          Text(" إعادة المحاولة",style: TextStyle(fontSize: 20),),
                        ],
                      ),),
                  ],
                ),
              ]),
              )
    ));
   }
  }
  
 

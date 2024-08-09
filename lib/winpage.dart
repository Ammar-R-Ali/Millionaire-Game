import 'package:flutter/material.dart';
import 'package:fluttercourse/insertname.dart';
class WinPage extends StatefulWidget {
  
  const WinPage({Key? key}):super(key: key);
  @override
  State<WinPage> createState()=> _WinState();}

   class _WinState extends State<WinPage>{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
             body:Container(
              padding: const EdgeInsets.all(10),
              color: Colors.blue[900],
              child: ListView(
                children: [
                const Center(child: Text("مبرووووك !!",
                textDirection:TextDirection.rtl,
                style: TextStyle(fontSize: 50,color: Color.fromARGB(255, 247, 222, 1)),)),
                const Center(child: Text("1000000\$",
                textDirection:TextDirection.rtl,
                style: TextStyle(fontSize: 80,color: Color.fromARGB(255, 247, 222, 1)),)),
                SizedBox(
                  height: 250,
                  width: 500,
                  child: Image.asset("images/congrats.jpg",fit: BoxFit.cover,)),
                  const Center(child: Text("لقد ربحت المليون",
                textDirection:TextDirection.rtl,
                style: TextStyle(fontSize: 50,color: Color.fromARGB(255, 247, 222, 1)),)),
               
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: Center(
                    child: Text("عمل رائع يا $firstName لقد انهيت اللعبة!",
                    textDirection:TextDirection.rtl,
                    style: const TextStyle(fontSize: 20,color: Colors.white),
                    ),
                  ),),

                Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  child: const Center(
                    child: Text("هل تود الذهاب إلى قائمة أعلى النتائج لرؤية تقدمك؟",
                    textDirection:TextDirection.rtl,
                    style: TextStyle(fontSize: 20,color: Colors.white),),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                      MaterialButton(
                      color: Colors.blue[700],
                      textColor: Colors.white,
                      height: 50,minWidth:150,
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
                      height: 50,minWidth:150,
                      shape: RoundedRectangleBorder(
                        side:  const BorderSide(color: Colors.white,width:2),
                        borderRadius: BorderRadius.circular(30)),
                      onPressed: (){Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
                      Navigator.of(context).pushNamed("highscores");
                      },
                      child:const Row(
                        children: [
                          Icon(Icons.emoji_events),
                           Text(" أعلى النتائج",style: TextStyle(fontSize: 20),),
                        ],
                      ),),
                  ],
                ),
              ]),
              )
    ));
   }
  }
  
 

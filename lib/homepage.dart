import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttercourse/sqldb.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}):super(key: key);
  @override
  State<HomePage> createState()=> _HomeState();}

   class _HomeState extends State<HomePage>{

   SqlDb sqlDb = SqlDb();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
             body: Container(
        color: Colors.blue[900],
        child:Column(
          children:[
          const Spacer(flex: 1),
          Expanded(flex: 5,
            child: SizedBox(
              width: 500,
              child :Image.asset("images/game name.jpg",fit: BoxFit.cover,),
            ),
          ),
          Expanded(
            flex: 6,
             child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
          MaterialButton(
            minWidth: 350,
            onPressed: (){Navigator.of(context).pushNamed("insertname");},
            color: Colors.blue[700],
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              side:  const BorderSide(color: Colors.white,width:2),
              borderRadius: BorderRadius.circular(30)),
            child: const Text("إبدأ مسابقة جديدة",style: TextStyle(fontSize: 40,)),),
          
          MaterialButton(
            minWidth: 350,
            onPressed: (){
              Navigator.of(context).pushNamed("highscores");
            },
            color: Colors.blue[700],
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              side:  const BorderSide(color: Colors.white,width:2),
              borderRadius: BorderRadius.circular(30)),
            child: const Text("أعلى النتائج",style: TextStyle(fontSize: 40,)),),
          
          MaterialButton(
            minWidth: 350,
            onPressed: (){Navigator.of(context).pushNamed("password");},
            color: Colors.blue[700],
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              side:  const BorderSide(color: Colors.white,width:2),
              borderRadius: BorderRadius.circular(30)),
            child: const Text("خيارات المطور",style: TextStyle(fontSize: 40,)),),
          
          MaterialButton(
            minWidth: 350,
            onPressed: (){exit(0);},
            color: Colors.blue[700],
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              side:  const BorderSide(color: Colors.white,width:2),
              borderRadius: BorderRadius.circular(30)),
            child: const Text("الخروج من اللعبة",style: TextStyle(fontSize: 40,)),),
            ]),
          ),
          const Spacer(flex: 1,)
       ])
    )));
   }
  }
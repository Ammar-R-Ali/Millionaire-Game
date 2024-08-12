// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttercourse/sqldb.dart';
class HighScores extends StatefulWidget {
  
  const HighScores({Key? key}):super(key: key);
  @override
  State<HighScores> createState()=> _HighScores();}

  class  _HighScores extends State<HighScores>{

  SqlDb sqlDb = SqlDb();
  bool isLoading=true;
  List players =[];
  void sortList(){
    players.sort((b,a)=>a['gain'].compareTo(b['gain']));// ترتيب تنازلي
  }

  Future readData() async{
    List<Map> response1 = await sqlDb.read("players");
    players.addAll(response1);
    isLoading=false;
    if(mounted){
      setState(() {
        
      });
    }
    sortList();
    return response1 ;
  }

@override
void initState() {
  super.initState(); 
  readData();
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(
          titleTextStyle:  const TextStyle(fontSize: 25,fontWeight: FontWeight.w700),
          title: const Text("أعلى النتائج"),
           backgroundColor: Colors.blue[700],
           leading:IconButton(onPressed: (){
            Navigator.of(context).pop();}, icon:const Icon(Icons.arrow_back))),
        floatingActionButton: FloatingActionButton(
          shape:RoundedRectangleBorder(
                  side:  const BorderSide(color: Colors.white,width:2),
                  borderRadius: BorderRadius.circular(30)),
          backgroundColor: Colors.purple[400],
           child:const Icon(Icons.delete_outlined,size: 35,),
          onPressed: (){
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context){
                return AlertDialog( //رسالة التنبيه
                title: const Text("هل تريد حذف القائمة؟",textAlign: TextAlign.center,),
                titlePadding: const EdgeInsets.all(10),
                titleTextStyle: const TextStyle(fontSize: 25,),
                content: const Text(" سيتم حذف معلومات جميع اللاعبين السابقين",textAlign: TextAlign.center,),
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
                    onPressed: ()async{
                      int response =await sqlDb.deleteTable("players");
                      Navigator.of(context).pop();
                      if(response>0){
                        Navigator.of(context).pushReplacementNamed("highscores");
                       
                       }},
                        child: const Text("نعم",style: TextStyle(fontSize: 20,color: Colors.white),)),],
                            );
                          }
                        );
                      },),
        body:isLoading==true ?
        Container(color: Colors.blue[900],child: const Center(child: Text("Loading...",style: TextStyle(color: Colors.white),)))
        :  Column(
          children: [
            Container(
              height: 50,
              color: Colors.blue[900],
              child: const Row(
                          children: [
                              Spacer(flex: 1,),
                              Expanded(flex:4, child: Text("المجموع",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w700),)),
                              Spacer(flex: 4,),
                              Expanded(flex:5,child: Text("اللاعب",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w700),)),
                              Spacer(flex: 2,),
                              Expanded(flex:3,child: Text("المرتبة",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w700),)),
                              Spacer(flex: 1,),
                          ],
                        ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(5),
                color: Colors.blue[900],
                child:
                    ListView(
                      children: [
                         ListView.builder(
                              itemCount: players.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context,i){
                                return Container(
                                  decoration: BoxDecoration(
                                  color: Colors.blue[700],
                                  border: Border.all(color: Colors.white,width: 3),
                                  borderRadius: BorderRadius.circular(25)),
                                  margin: const EdgeInsets.only(bottom: 15),
                                  height: 80,
                                  child: Row(
                                  children: [
                                    const Spacer(flex: 1,),
                                    Expanded(
                                      flex:3,
                                      child: Text("${players[i]['gain']}",style: const TextStyle(fontSize: 20,color: Colors.white),)),
                                    const Spacer(flex: 2,),
                                    Expanded(
                                      flex: 5,
                                      child: Text("${players[i]['f_name']} ${players[i]['l_name']} ",style: const TextStyle(fontSize: 20,color: Colors.white),)),
                                    const Spacer(flex: 1,),
                                    Expanded(
                                      flex:1,
                                      child: Text("${i+1}",style: const TextStyle(fontSize: 20,color: Colors.white),)),
                                    const Spacer(flex: 1,),
                                    ]));
                                  })
                ]),
              ),
            ),
          ],
        ),
    ));
      }}


import 'package:flutter/material.dart';
import 'package:fluttercourse/sqldb.dart';
class QuestionsList extends StatefulWidget {
  const QuestionsList({Key? key}):super(key: key);
  @override
  State<QuestionsList> createState()=> _QuestionsListState();}

  class  _QuestionsListState extends State<QuestionsList>{
  SqlDb sqlDb = SqlDb();
  bool isLoading=true;
  List questions1 =[];
  List questions2 =[];
  List questions3 =[];

  Future readData1() async{
    List<Map> response1 = await sqlDb.read("easyQuestions");
    questions1.addAll(response1);
    questions1=questions1.reversed.toList();
    isLoading=false;
    if(mounted){
      setState(() {});}
    return response1 ;
  }
  Future readData2() async{
    List<Map> response2 = await sqlDb.read("mediumQuestions");
    questions2.addAll(response2);
    questions2=questions2.reversed.toList();
    isLoading=false;
    if(mounted){
      setState(() {});}
    return response2;
  }
  Future readData3() async{
    List<Map> response3= await sqlDb.read("hardQuestions");
    questions3.addAll(response3);
    questions3=questions3.reversed.toList();
    isLoading=false;
    if(mounted){
      setState(() {});
    }
    return response3 ;
  }


@override
void initState() {
  super.initState(); 
  readData1();
  readData2();
  readData3();
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:DefaultTabController(
        length: 3,
        child:Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[700],
          title: const Text("قائمة الأسئلة"),
          titleTextStyle: const TextStyle(fontSize: 25,fontWeight: FontWeight.w700),
          centerTitle: true,
          leading: IconButton(onPressed: (){Navigator.of(context).pop();}, icon:const Icon(Icons.arrow_back)),
          bottom: TabBar(
            indicatorColor: Colors.yellow[600],
            indicatorWeight: 5,
            labelColor: Colors.yellow[600],
            labelStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600),
            unselectedLabelColor: Colors.white,
            unselectedLabelStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w500),
            tabs:const [
              Tab(child: Text("المستوى السهل"),),
              Tab(child: Text("المستوى المتوسط"),),
              Tab(child: Text("المستوى الصعب"),),
            ] ),),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.yellow[600],
          shape:RoundedRectangleBorder(
             side:  const BorderSide(color: Colors.white,width:2),
             borderRadius: BorderRadius.circular(30)),
          onPressed: (){ Navigator.of(context).pushReplacementNamed("addquestions");},
          child:const Icon(Icons.add,size: 40,)),
        body:isLoading==true ?
        Container(color: Colors.blue[900],child: const Center(child: Text("Loading...",style: TextStyle(color: Colors.white),)))
        :  Container(
          padding: const EdgeInsets.all(10),
          color: Colors.blue[900],
          child:TabBarView(
            children: [
              ListView(
                children: [
                   ListView.builder(
                        itemCount: questions1.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context,i){
                          return Card(
                            color: Colors.blue[700],
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.white,width: 2),
                              borderRadius: BorderRadius.circular(25)),
                            child: ListTile(
                            textColor: Colors.white,
                            title: Text("${questions1[i]['question']}",textDirection: TextDirection.rtl,),
                            titleTextStyle: const TextStyle(fontSize: 20),
                            subtitle: Text("${questions1[i]['answerT']}",textDirection: TextDirection.rtl,),
                            subtitleTextStyle:const TextStyle(fontSize: 18),
                            leading: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: ()async{
                                   int response =await sqlDb.delete("easyQuestions", "id=${questions1[i]['id']}");
                                    if(response>0){
                                      questions1.removeWhere((element) => element['id'] == questions1[i]['id']);
                                      setState(() {
                                        
                                      });
                                    }
                                  },
                                  icon:const Icon(
                                    Icons.delete,
                                    color: Colors.white,)),
                              ],
                            ),
                          ),);
                        })
                ],
              ),
            //****************************************************************************************************
             ListView(
                children: [
                   ListView.builder(
                        itemCount: questions2.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context,i){
                          return Card(
                            color: Colors.blue[700],
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.white,width: 2),
                              borderRadius: BorderRadius.circular(25)),
                            child: ListTile(
                            textColor: Colors.white,
                            title: Text("${questions2[i]['question']}",textDirection: TextDirection.rtl,),
                            subtitle: Text("${questions2[i]['answerT']}",textDirection: TextDirection.rtl,),
                            titleTextStyle: const TextStyle(fontSize: 20),
                            subtitleTextStyle:const TextStyle(fontSize: 18),
                            leading: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: ()async{
                                   int response =await sqlDb.delete("mediumQuestions", "id=${questions2[i]['id']}");
                                    if(response>0){
                                      questions2.removeWhere((element) => element['id'] == questions2[i]['id']);
                                      setState(() {
                                        
                                      });
                                    }
                                  },
                                  icon:const Icon(
                                    Icons.delete,
                                    color: Colors.white,)),
                              ],
                            ),
                          ),);
                        })
                ],
              ),
            //****************************************************************************************************
             ListView(
                children: [
                   ListView.builder(
                        itemCount: questions3.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context,i){
                          return Card(
                            color: Colors.blue[700],
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.white,width: 2),
                              borderRadius: BorderRadius.circular(25)),
                            child: ListTile(
                            textColor: Colors.white,
                            title: Text("${questions3[i]['question']}",textDirection: TextDirection.rtl,),
                            subtitle: Text("${questions3[i]['answerT']}",textDirection: TextDirection.rtl,),
                            titleTextStyle: const TextStyle(fontSize: 20),
                            subtitleTextStyle:const TextStyle(fontSize: 18),
                            leading: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: ()async{
                                   int response =await sqlDb.delete("hardQuestions", "id=${questions3[i]['id']}");
                                    if(response>0){
                                      questions3.removeWhere((element) => element['id'] == questions3[i]['id']);
                                      setState(() {
                                        
                                      });
                                    }
                                  },
                                  icon:const Icon(
                                    Icons.delete,
                                    color: Colors.white,)),
                              ],
                            ),
                          ),);
                        })
                ],
              ),
            ],
          )
          ),
        ),
    ));
      }}


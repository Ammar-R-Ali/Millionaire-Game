import 'package:flutter/material.dart';
import 'package:fluttercourse/sqldb.dart';
import 'package:fluttercourse/addquestions.dart';
import 'package:fluttercourse/develop.dart';
import 'package:fluttercourse/gamepage.dart';
import 'package:fluttercourse/highscores.dart';
import 'package:fluttercourse/homepage.dart';
import 'package:fluttercourse/insertname.dart';
import 'package:fluttercourse/password.dart';
import 'package:fluttercourse/questionslist.dart';
import 'package:fluttercourse/winpage.dart';
import 'package:fluttercourse/losepage.dart';

void main() async {
 
  // التأكد من تهيئة الفريمورك
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة قاعدة البيانات
  SqlDb sqlDb = SqlDb();
  await sqlDb.db; // هذا يستدعي الدالة التي تقوم بإنشاء قاعدة البيانات وتطبيق البيانات الأولية

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      routes: {
        "home": (context) => const HomePage(),
        "develop": (context) => const Develop(),
        "password": (context) => const PassWord(),
        "game": (context) => const GamePage(),
        "insertname": (context) => const InsertName(),
        "win": (context) => const WinPage(),
        "lose": (context) => const LosePage(),
        "highscores": (context) => const HighScores(),
        "questionslist": (context) => const QuestionsList(),
        "addquestions": (context) => const AddQuestions(),
      },
    );
  }
}
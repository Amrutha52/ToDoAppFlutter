import 'package:flutter/material.dart';
import 'package:todoapp/utils/AppSessions.dart';
import 'package:todoapp/view/bottomnav_screen/BottomNavScreen.dart';
import 'package:todoapp/view/home_screen/HomeScreen.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async
{
  await Hive.initFlutter(); // Initialization
  var box = await Hive.openBox(AppSessions.TODOBOX);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo App',
      home: BottomNavScreen(),
    );
  }
}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide CarouselController;

import '../bottomnav_screen/BottomNavScreen.dart';

class HomeScreen extends StatefulWidget
{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Home", style: TextStyle(color: Colors.white,
        fontWeight: FontWeight.bold
        ),
        ),
        actions: [
          Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: Icon(Icons.account_circle_rounded, size: 40,),
          )
        ],
      ),
      body: Center(
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavScreen()));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("What do you want to do today?",
                style: TextStyle(color: Colors.white,
                    fontSize: 20
                ),
              ),
              SizedBox(height: 10,),
              Text("Tap + to add your tasks",
                style: TextStyle(color: Colors.white,
                    fontSize: 16
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

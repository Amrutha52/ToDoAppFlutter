import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/utils/ImageConstants.dart';
import 'package:todoapp/view/calendar_screen/CalendarScreen.dart';
import 'package:todoapp/view/focus_screen/FocusScreen.dart';
import 'package:todoapp/view/profile_screen/ProfileScreen.dart';

import '../home_screen/HomeScreen.dart';

class BottomNavScreen extends StatefulWidget
{
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen>
{
  int selectedIndex = 0;
  List<Widget> myScreens = [
    HomeScreen(),
    Calendarscreen(),
    FocusScreen(),
    ProfileScreen()

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myScreens[selectedIndex],
      backgroundColor: Colors.black,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.deepPurpleAccent.shade100,
          onPressed: (){},
      child: Icon(Icons.add, size: 30,),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 10,
        selectedFontSize: 10,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold,),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal,),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.white,),
              label: "Home"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month, color: Colors.white,),
            label: "Calendar",
          ),
          BottomNavigationBarItem(
            label: "Focus",
            icon: Icon(Icons.timelapse, color: Colors.white,),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.account_circle_rounded, color: Colors.white,),
          ),

        ],
        onTap: (value){
          selectedIndex = value;
          setState(() {

          });
        },
      ),
    );
  }
}

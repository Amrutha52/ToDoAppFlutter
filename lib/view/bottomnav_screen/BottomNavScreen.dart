import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todoapp/utils/AppSessions.dart';
import 'package:todoapp/utils/ImageConstants.dart';
import 'package:todoapp/view/calendar_screen/CalendarScreen.dart';
import 'package:todoapp/view/focus_screen/FocusScreen.dart';
import 'package:todoapp/view/profile_screen/ProfileScreen.dart';

import '../../utils/ColorConstants.dart';
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

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  var toDoBox = Hive.box(AppSessions.TODOBOX);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myScreens[selectedIndex],
      backgroundColor: Colors.black,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.deepPurpleAccent.shade100,
          onPressed: (){
            _customBottomSheet(context); // Bottom Sheet appears when clicking floating button
          },
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

  Future<dynamic> _customBottomSheet(BuildContext context)
  {
    return showModalBottomSheet(
      backgroundColor: Colorconstants.blackShade1,
        context: context,
        builder: (context) => Padding(
            padding: const EdgeInsets.all(20),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom), // MediaQuery veche kannunna section vare padding konde vara
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Add Task", style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                        hintText: "Title",
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: descController,
                    maxLines: 5,
                    decoration: InputDecoration(
                        hintText: "Description",
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(height: 20),

                  Row(
                    children: [
                      Icon(Icons.access_alarm, size: 20, color: Colors.white,),
                      SizedBox(width: 30,),
                      Icon(Icons.category_outlined, size: 20, color: Colors.white,),
                      SizedBox(width: 30,),
                      Icon(Icons.flag, size: 20, color: Colors.white,),
                      Spacer(),
                      Icon(Icons.send, size: 20,color: Colors.white,)
                    ],
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}

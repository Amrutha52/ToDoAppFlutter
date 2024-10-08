import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:intl/intl.dart';
import 'package:simple_horizontal_calendar/horizontal_calendar.dart';
//import 'package:horizontal_week_calendar/horizontal_week_calendar.dart';
import 'package:todoapp/utils/ColorConstants.dart';

class Calendarscreen extends StatefulWidget
{
  const Calendarscreen({super.key});

  @override
  State<Calendarscreen> createState() => _CalendarscreenState();
}

class _CalendarscreenState extends State<Calendarscreen>
{
 // var selectedDate = DateTime.now();
  String selectedDate = "";

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        selectedDate = DateFormat('dd MMMM, yyyy').format(DateTime.now());
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context)

  {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text("Calendar", style: TextStyle(color: Colors.white,
              fontWeight: FontWeight.bold
          ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            // Horizontal Calendar is added
            // HorizontalWeekCalendar(
            //   minDate: DateTime(2023, 12, 31),
            //   maxDate: DateTime(2030, 1, 31),
            //   initialDate: DateTime.now(),
            //   onDateChange: (date) {
            //     setState(() {
            //       selectedDate = date;
            //     });
            //   },
            //   //showTopNavbar: false,
            //   monthFormat: "MMMM yyyy",
            //   showNavigationButtons: true,
            //   weekStartFrom: WeekStartFrom.Monday,
            //   borderRadius: BorderRadius.circular(7),
            //   activeBackgroundColor: Colorconstants.blackShade1,
            //   activeTextColor: Colors.white,
            //   inactiveBackgroundColor: Colors.black.withOpacity(.3),
            //   inactiveTextColor: Colors.white,
            //   disabledTextColor: Colors.grey,
            //   disabledBackgroundColor: Colors.grey.withOpacity(.3),
            //   activeNavigatorColor: Colorconstants.blackShade1,
            //   inactiveNavigatorColor: Colors.grey,
            //   monthColor: Colors.white,
            // ),
            Container(
              color: Colorconstants.blackShade1,
              child: HorizontalCalender(
                onSelected: (DateTime date) {
                  setState(() {
                    selectedDate = DateFormat('dd MMMM, yyyy').format(date);
                  });
                },
              ),
            ),
            SizedBox(height: 20,),

            //Container
            Center(
              child: Container(
                height: 100,
                width: 300,
                color: Colorconstants.blackShade1,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(50, 20, 10, 20),
                  child: Row(
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:  MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                              side: BorderSide(color: Colors.deepPurpleAccent.shade200)

                            )
                          )
                        ),
                          onPressed: (){},
                          child: Text("Today", style: TextStyle(color: Colors.white),)
                      ),
                      Spacer(),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:  MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                      side: BorderSide(color: Colors.deepPurpleAccent.shade200)

                                  )
                              )
                          ),
                          onPressed: (){},
                          child: Text("Completed", style: TextStyle(color: Colors.white),)
                      ),
                    ],
                  ),
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}

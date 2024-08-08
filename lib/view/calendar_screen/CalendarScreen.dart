import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_week_calendar/horizontal_week_calendar.dart';
import 'package:todoapp/utils/ColorConstants.dart';

class Calendarscreen extends StatefulWidget
{
  const Calendarscreen({super.key});

  @override
  State<Calendarscreen> createState() => _CalendarscreenState();
}

class _CalendarscreenState extends State<Calendarscreen>
{
  var selectedDate = DateTime.now();

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
            HorizontalWeekCalendar(
              minDate: DateTime(2023, 12, 31),
              maxDate: DateTime(2030, 1, 31),
              initialDate: DateTime.now(),
              onDateChange: (date) {
                setState(() {
                  selectedDate = date;
                });
              },
              //showTopNavbar: false,
              monthFormat: "MMMM yyyy",
              showNavigationButtons: true,
              weekStartFrom: WeekStartFrom.Monday,
              borderRadius: BorderRadius.circular(7),
              activeBackgroundColor: Colorconstants.blackShade1,
              activeTextColor: Colors.white,
              inactiveBackgroundColor: Colors.black.withOpacity(.3),
              inactiveTextColor: Colors.white,
              disabledTextColor: Colors.grey,
              disabledBackgroundColor: Colors.grey.withOpacity(.3),
              activeNavigatorColor: Colorconstants.blackShade1,
              inactiveNavigatorColor: Colors.grey,
              monthColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

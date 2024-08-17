import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/utils/ColorConstants.dart';

class ToDoDetailsScreen extends StatefulWidget
{
  const ToDoDetailsScreen({super.key,
    required this.todoDesc,
    required this.title,
    required this.date});
  final String todoDesc;
  final String title;
  final String date;

  @override
  State<ToDoDetailsScreen> createState() => _ToDoDetailsScreenState(todoDesc, title, date);
}

class _ToDoDetailsScreenState extends State<ToDoDetailsScreen>
{
  _ToDoDetailsScreenState(this.todoDesc,
      this.title,
      this.date
      );
  String todoDesc, title, date;

  @override
  Widget build(BuildContext context)
  {
    var screenWidth = MediaQuery.sizeOf(context).width; // To determine width
    var screenHeight = MediaQuery.sizeOf(context).height; // To determine height

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          height: screenHeight,
          width: screenWidth,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(width: 10, color: Colors.white),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                todoDesc,
                maxLines: 1000,
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 10,),
              // Align widget is used for Text alignment purpose
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  date,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
        )
    );
  }
}

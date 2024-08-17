import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/utils/AppSessions.dart';
import 'package:todoapp/view/home_screen/widgets/ToDoCard.dart';
import 'package:todoapp/view/todo_details_screen/ToDoDetailsScreen.dart';

import '../../utils/ColorConstants.dart';


class HomeScreen extends StatefulWidget
{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
{
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  var todoBox = Hive.box(AppSessions.TODOBOX);

  var todoKeys = AppSessions.todoKeys;

  @override
  void initState()
  {
    // App open aavumbol thanne valuesne pick cheythe konde varum
    todoKeys = todoBox.keys.toList();
    setState(() {});
    super.initState();

  }

  @override
  Widget build(BuildContext context)
  {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("HomeScreen", style: TextStyle(color: Colors.white),),
        ),
          backgroundColor: Colors.black,
          // floatingActionButton: FloatingActionButton(
          //   backgroundColor: Colors.grey.shade300,
          //   onPressed: () {
          //     titleController.clear();  // oro thavaneyum aa oru bottom sheet varune munne data clear aavum. To clear controllers before opening the bottom sheet again..
          //     descController.clear();
          //     dateController.clear();
          //
          //     _customBottomSheet(context);
          //   },
          //   child: Icon(Icons.add),
          // ),
          body: ListView.separated(
              padding: EdgeInsets.all(15),
              itemBuilder: (context, index) {
                var currentTodo = todoBox.get(todoKeys[index]);
                return InkWell(
                  onTap: ()
                  {
                    //Sending Details to the ToDoDetails Screen
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ToDoDetailsScreen(todoDesc: currentTodo["desc"],
                      title: currentTodo["title"],
                      date: currentTodo["date"],
                    )));
                  },
                  child: ToDoCard(

                    date:currentTodo["date"] ,
                    desc: currentTodo["desc"],
                    title: currentTodo["title"],
                    // for deletion
                    onDelete: () {
                      todoBox.delete(todoKeys[index]);
                      todoKeys = todoBox.keys.toList(); // delete cheyumbol oru key povum athonde nammude kayillulla list update cheyanam.
                      setState(() {});
                    },
                    // for editing
                    onEdit: () {
                      titleController.text = currentTodo["title"]; // UI il kannikunna dataye controlleril kanikunnu
                      dateController.text = currentTodo["date"]; // Hiveil ninne edukunnu
                      descController.text = currentTodo["desc"];

                      _customBottomSheet(context,
                          isEdit: true, itemIndex: index); // Edit varumbol isEdit true aayitulla BottomSheetine call cheyum,
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
              itemCount: todoKeys.length)
      ),
    );
  }

  Future<dynamic> _customBottomSheet(BuildContext context,
      {bool isEdit = false, int? itemIndex}) {
    return showModalBottomSheet(
        backgroundColor: Colorconstants.blackShade1,
        isScrollControlled: true,
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
                  TextFormField(
                    readOnly: true, // to avoid textfield typing
                    controller: dateController,
                    decoration: InputDecoration(
                        hintText: "Date",
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        suffixIcon: IconButton(onPressed: () async {
                          var selectedDate = await showDatePicker(context: context,
                              firstDate: DateTime(2024),
                              lastDate: DateTime.now());
                          if(selectedDate != null)
                          {
                            dateController.text = DateFormat("dd MMM yyyy").format(selectedDate);
                          }

                        },
                            icon: Icon(Icons.calendar_month)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      // Icon(Icons.access_alarm, size: 20, color: Colors.white,),
                      // SizedBox(width: 30,),
                      // Icon(Icons.category_outlined, size: 20, color: Colors.white,),
                      // SizedBox(width: 30,),
                      // Icon(Icons.flag, size: 20, color: Colors.white,),
                      Spacer(),
                      // Update
                      InkWell(
                          onTap: ()
                          {
                            if (isEdit == true)
                              {
                                todoBox.put(todoKeys[itemIndex!],{
                                  "title": titleController.text,
                                  "desc": descController.text,
                                  "date": dateController.text,
                                });

                              }

                            todoKeys = todoBox.keys.toList();
                            Navigator.pop(context); // Bottom sheet closing
                            setState(() {});
                          },
                          child: Icon(Icons.update, size: 20,color: Colors.white,
                          )
                      )
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


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/utils/AppSessions.dart';
import 'package:todoapp/view/home_screen/widgets/ToDoCard.dart';
import 'package:todoapp/view/todo_details_screen/ToDoDetailsScreen.dart';

import '../bottomnav_screen/BottomNavScreen.dart';

// class HomeScreen extends StatefulWidget
// {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen>
// {
//   @override
//   Widget build(BuildContext context)
//   {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: Text("Home", style: TextStyle(color: Colors.white,
//         fontWeight: FontWeight.bold
//         ),
//         ),
//         actions: [
//           Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
//           child: Icon(Icons.account_circle_rounded, size: 40,),
//           )
//         ],
//       ),
//       body: Center(
//         child: InkWell(
//           onTap: (){
//             Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavScreen()));
//           },
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text("What do you want to do today?",
//                 style: TextStyle(color: Colors.white,
//                     fontSize: 20
//                 ),
//               ),
//               SizedBox(height: 10,),
//               Text("Tap + to add your tasks",
//                 style: TextStyle(color: Colors.white,
//                     fontSize: 16
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class HomeScreen extends StatefulWidget
{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  int selectedColorIndex = 0; //currently selected color index kittaan

  var todoBox = Hive.box(AppSessions.TODOBOX);

  List todoKeys = [];

  @override
  void initState()
  {
    // App open aavumbol thanne valuesne pick cheythe konde varum
    todoKeys = todoBox.keys.toList();
    setState(() {});
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.grey.shade300,
            onPressed: () {
              titleController.clear();  // oro thavaneyum aa oru bottom sheet varune munne data clear aavum. To clear controllers before opening the bottom sheet again..
              descController.clear();
              dateController.clear();
             // selectedColorIndex = 0;
              _customBottomSheet(context); //isEdit false aayitulla BottomSheetine call cheyum,
            },
            child: Icon(Icons.add),
          ),
          body: ListView.separated(
              padding: EdgeInsets.all(15),
              itemBuilder: (context, index) {
                var currentTodo = todoBox.get(todoKeys[index]);
                return InkWell(
                  onTap: ()
                  {
                    //Sending Details to the NoteDetails Screen
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ToDoDetailsScreen(todoDesc: currentTodo["desc"],
                      title: currentTodo["title"],
                      date: currentTodo["date"],
                      //noteColor: DummyDB.noteColors[currentNote["colorIndex"]],
                    )));
                  },
                  child: ToDoCard(
                    //noteColor: DummyDB.noteColors[currentNote["colorIndex"]], // DummyDB.notesList[index]["colorIndex"] store cheytha data edukan vendiyulla code, hive il ninne index eduthitte DummyDByile colorsil ninne edukane cheyane.
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
                      //selectedColorIndex = currentNote["colorIndex"];
                      // titleController = TextEditingController(
                      //     text: DummyDb.notesList[index]["title"]); // Another method
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
      {bool isEdit = false, int? itemIndex}) { // IsBool edit false aaki koduthu, add cheyumbol false aane, data add cheythe kazhinja true aaki kodukum, itemIndex edit aanenkil venam illenkil venda
    return showModalBottomSheet(
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

                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (isEdit == true) {
                              todoBox.put(todoKeys[itemIndex!],{
                                "title": titleController.text,
                                "desc": descController.text,
                               // "colorIndex": selectedColorIndex,
                                "date": dateController.text,
                              });
                              // DummyDB.notesList[itemIndex!] = {  // item indexileke puthiya mapine add cheyanam, epo controllerileke ulla values aa particular indexileke add aavum.
                              //   "title": titleController.text,
                              //   "desc": descController.text,
                              //   "colorIndex": selectedColorIndex,
                              //   "date": dateController.text,
                              // };

                            } else {
                              //Step 3
                              todoBox.add({ // Edit allenkil new add aavum.
                                "title": titleController.text,
                                "desc": descController.text,
                                "date": dateController.text,
                                //"colorIndex": selectedColorIndex
                              });
                            }
                            todoKeys = todoBox.keys.toList();
                            Navigator.pop(context); // Bottom sheet closing
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              isEdit ? "Update" : "Save", // isEdit aanenkil Update varum.
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}


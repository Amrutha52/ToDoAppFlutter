import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToDoDetailsScreen extends StatefulWidget
{
  const ToDoDetailsScreen({super.key, required todoDesc, required title, required date});

  @override
  State<ToDoDetailsScreen> createState() => _ToDoDetailsScreenState();
}

class _ToDoDetailsScreenState extends State<ToDoDetailsScreen>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

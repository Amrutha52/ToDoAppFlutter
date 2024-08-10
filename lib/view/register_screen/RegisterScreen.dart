import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget
{
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Text("Register", style: TextStyle(color: Colors.white,
              fontSize: 20,
          fontWeight: FontWeight.bold
          ),),
          SizedBox(height: 10,),
          
        ],
      ),
    );
  }
}

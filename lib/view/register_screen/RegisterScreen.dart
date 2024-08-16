import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../utils/AppSessions.dart';
import '../login_screen/LoginMainScreen.dart';



class RegisterScreen extends StatelessWidget
{
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    final _emailFormKey = GlobalKey<FormState>();
    final _passwordFormKey = GlobalKey<FormState>();
    final _confirmPasswordFormKey = GlobalKey<FormState>();

    var loginBox = Hive.box(AppSessions.LOGINBOX);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              Text("Sign Up For Free", style: TextStyle(color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold, fontSize: 25),),
              SizedBox(height: 30,),
              Form(
                  key: _emailFormKey,
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid email:';
                      }
                      else if(value.contains("@"))
                      {
                        return null;
                      }

                      else
                      {
                        return "Invalid Email Address";
                      }

                    },
                    decoration: InputDecoration(
                      label: Text("Your Email Address", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      labelStyle: TextStyle(color: Colors.white),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.grey.shade200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.blueAccent),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.red),
                      ),
                    ),
                  )),
              SizedBox(height: 16,),
              Form(
                  key: _passwordFormKey,
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: passwordController,
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid password:';
                      }
                      else if(value.length >= 8 && value != null)
                      {
                        return null;
                      }

                      else
                      {
                        return "Invalid Password";
                      }

                    },
                    decoration: InputDecoration(
                      label: Text("Your Password", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      labelStyle: TextStyle(color: Colors.white),
                      suffixIcon: Icon(Icons.remove_red_eye, color: Colors.grey,),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.grey.shade200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.blueAccent),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.red),
                      ),
                    ),
                  )),
              SizedBox(height: 16,),
              Form(
                  key: _confirmPasswordFormKey,
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: confirmPasswordController,
                    validator: (value){
                      if (value == null || value.isEmpty)
                      {
                        return 'Please enter a valid password:';
                      }
                      else if(value != passwordController.text)
                      {
                        return "Password and Confirm Password not match";
                      }
                      else if(value.length >= 8 && value == passwordController.text)
                      {
                        return null;
                      }

                      else
                      {
                        return "Invalid Password";
                      }

                    },
                    decoration: InputDecoration(
                      label: Text("Your Confirm Password", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      labelStyle: TextStyle(color: Colors.white),
                      suffixIcon: Icon(Icons.remove_red_eye, color: Colors.grey,),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.grey.shade200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.blueAccent),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.red),
                      ),
                    ),
                  )),
              SizedBox(height: 16,),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,

                      ))
                  ),
                  onPressed: (){

                    // Validate returns true if the form is valid, or false otherwise.
                    if (_emailFormKey.currentState!.validate() && _passwordFormKey.currentState!.validate() && _confirmPasswordFormKey.currentState!.validate())
                    {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.

                      loginBox.add({ // Edit allenkil new add aavum.
                        "useremail": emailController.text,
                        "userpassword": passwordController.text,
                        "userconfirmpassword": confirmPasswordController.text
                      });

                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginMainScreen()));
                      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);

                      //   // print("Invaild credentials");


                    }
                    else
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Invalid Credentials'),
                          // action: SnackBarAction(label: "Close", onPressed: () {}),
                          duration: Duration(seconds: 10),
                          padding: EdgeInsets.all(30),
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(10), // outersideleke gap varan
                        ),
                      );
                    }
                  },
                  child: Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 18),)
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Already have an account?", style: TextStyle(color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold),),
                    SizedBox(width: 10,),
                    InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginMainScreen()));
                        },
                        child: Text("Sign In", style: TextStyle(color: Colors.lightBlue, fontWeight: FontWeight.bold),))
                  ],
                ),)
            ],
          ),
        ),
      ),
    );
  }
}

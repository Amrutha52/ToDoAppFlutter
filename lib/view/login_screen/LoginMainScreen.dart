import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../utils/AppSessions.dart';
import '../bottomnav_screen/BottomNavScreen.dart';
import '../home_screen/HomeScreen.dart';
import '../register_screen/RegisterScreen.dart';

class LoginMainScreen extends StatelessWidget
{
  const LoginMainScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    final _emailFormKey = GlobalKey<FormState>();
    final _passwordFormKey = GlobalKey<FormState>();

    var loginBox = Hive.box(AppSessions.LOGINBOX);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            Text("Sign in to Your Account", style: TextStyle(color: Colors.deepPurpleAccent.shade400, fontWeight: FontWeight.bold, fontSize: 25),),
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
                    labelStyle: TextStyle(color: Colors.grey),
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
                    labelStyle: TextStyle(color: Colors.grey),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400)
                  ),
                ),
                SizedBox(width: 10,),
                Text("Remember Me", style: TextStyle(color: Colors.deepPurpleAccent.shade400, fontWeight: FontWeight.bold),),
                Spacer(),
                Text("Forgot Password", style: TextStyle(color: Colors.lightBlue, fontWeight: FontWeight.bold),)
              ],
            ),
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
                  if (_emailFormKey.currentState!.validate() && _passwordFormKey.currentState!.validate())
                  {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    // if (emailController.text == storedEmail && passwordController.text == storedPass)
                    // {

                    loginBox.get({ // Edit allenkil new add aavum.
                      "useremail": emailController.text,
                      "userpassword": passwordController.text,
                    });
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                    //  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);

                    // }
                    // else
                    // {
                    //   // print("Invaild credentials");
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(
                    //       backgroundColor: Colors.red,
                    //       content: Text('Invalid Credentials'),
                    //       // action: SnackBarAction(label: "Close", onPressed: () {}),
                    //       duration: Duration(seconds: 10),
                    //       padding: EdgeInsets.all(30),
                    //       behavior: SnackBarBehavior.floating,
                    //       margin: EdgeInsets.all(10), // outersideleke gap varan
                    //     ),
                    //   );
                    // }

                  }
                },
                child: Text("Sign In", style: TextStyle(color: Colors.white, fontSize: 18),)
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Don't have an account?", style: TextStyle(color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold),),
                  SizedBox(width: 10,),
                  InkWell(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                      },
                      child: Text("Sign Up", style: TextStyle(color: Colors.lightBlue, fontWeight: FontWeight.bold),))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

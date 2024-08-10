import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide CarouselController;

class LoginScreen extends StatefulWidget 
{
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> 
{
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50,),
            Text("Welcome", style: TextStyle(
                color: Colors.white, 
                fontSize: 25,
                fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            Text("Please login to your account or create new account to continue",
            style: TextStyle(color: Colors.white, fontSize: 14),),
            Spacer(),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(color: Colors.deepPurpleAccent.shade200)

                        )
                    )
                ),
                onPressed: (){},
                child: Text("Login", style: TextStyle(color: Colors.white),)
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(color: Colors.deepPurpleAccent.shade200)

                        )
                    )
                ),
                onPressed: (){},
                child: Text("CREATE ACCOUNT", style: TextStyle(color: Colors.white),)
            ),
          ],
        ),
      ),
    );
  }
}

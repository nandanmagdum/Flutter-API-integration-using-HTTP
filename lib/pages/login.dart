import 'package:flutter/material.dart';
import 'package:http_example/localDB.dart';
import 'package:http_example/pages/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController controller = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () async{
        print(Localdb.prefs.getString(Localdb.NAME));
        print(Localdb.prefs.getBool(Localdb.LOGGEDIN));
      },),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width : MediaQuery.of(context).size.width),
            Text("Login", style: TextStyle(fontSize: 40),),
            SizedBox(height: 40,),
            TextFormField(
              controller:  controller,
              decoration: InputDecoration(
                hintText: "Enter your name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 20,),
            if (isLoading) CircularProgressIndicator() ,
            ElevatedButton(onPressed: () async{
              try {
                setState(() {
                isLoading = true;
              });
              print(controller.text);
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString("name", controller.text);
              prefs.setBool("logedIn", true);
              prefs.setStringList("likes", <String>[]);
              setState(() {
                isLoading = false;
              });
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage(),));
              } catch (e) {
                print("this is exception : ${e}");
                setState(() {
                  isLoading = false;
                });
              }
            }, child: Text("Login"),),
          ],
        ),
      ),
    );
  }
}
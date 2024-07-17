import 'package:flutter/material.dart';
import 'package:http_example/localDB.dart';
import 'package:http_example/pages/homePage.dart';
import 'package:http_example/pages/login.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Localdb.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Localdb.prefs.getBool(Localdb.LOGGEDIN) ?? false ? HomePage() : LoginScreen(),
    );
  }
}
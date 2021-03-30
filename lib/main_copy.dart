import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:solution_challenge_2021/helper/Database.dart';
import 'package:solution_challenge_2021/repositories/user_dao.dart';
import 'package:solution_challenge_2021/views/Screens/Login/login_screen.dart';
import 'package:solution_challenge_2021/views/Screens/Welcome/welcome_screen.dart';
import 'package:solution_challenge_2021/views/constants.dart';
import 'package:solution_challenge_2021/views/home/HomePage.dart';
import 'package:solution_challenge_2021/views/visualization/ReportPage.dart';
import 'package:sqflite/sqflite.dart';

import 'models/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isAuth = false;

  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    ReportPage(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }



  @override
  Widget build(BuildContext context) {
    /// Initialize SQLite database
   WidgetsFlutterBinding.ensureInitialized();



    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: WelcomeScreen());
  }
}
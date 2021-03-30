import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:solution_challenge_2021/helper/database.dart';
import 'package:solution_challenge_2021/repositories/user_dao.dart';
import 'package:solution_challenge_2021/views/Screens/Login/login_screen.dart';
import 'package:solution_challenge_2021/views/Screens/Welcome/welcome_screen.dart';
import 'package:solution_challenge_2021/views/constants.dart';
import 'package:solution_challenge_2021/views/home/HomePage.dart';
import 'package:solution_challenge_2021/views/quiz/welcome/welcome_screen.dart';
import 'package:solution_challenge_2021/views/visualization/ReportPage.dart';

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {

  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    QuizWelcomeScreen(),
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

    return Scaffold(
        body: _widgetOptions[_selectedIndex],
        bottomNavigationBar: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent

          ),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.analytics_outlined),
                label: 'Quiz',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: kPrimaryColor,
            onTap: _onItemTapped,
          ),
        ));
  }
}
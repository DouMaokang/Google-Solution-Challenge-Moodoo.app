import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:solution_challenge_2021/helper/global.dart';
import 'package:solution_challenge_2021/repositories/session_dao.dart';
import 'package:solution_challenge_2021/views/calendar/calendar_screen.dart';
import 'package:solution_challenge_2021/views/components/rounded_button.dart';
import 'package:solution_challenge_2021/views/recorder/InstructionPage/instruction_screen.dart';

import '../constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future _session = SessionDAO.sessionDAO.getAllSession();
  int _current = 0;
  String _userName = Global.global.getUsername()[0].toUpperCase() +
      Global.global.getUsername().substring(1);
  String _greetings = "Welcome,";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder(
          future: _session,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return Text("");
            } else if (snapshot.hasData) {
              print(snapshot.data);
              final List<Map> sessions = snapshot.data;
              print(sessions);

              return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.fromLTRB(24, 8, 16, 8),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _greetings,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: textPrimaryColor,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    _userName,
                                    style: TextStyle(
                                        color: textPrimaryColor,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              IconButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                icon: Icon(Icons.calendar_today_outlined),
                                tooltip: 'Calendar',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return CalendarScreen();
                                    }),
                                  );
                                },
                              ),
                            ])),
                    Container(
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: (MediaQuery.of(context).size.height) * 0.7,
                          // aspectRatio: 6/5,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 5),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 1600),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          },
                          scrollDirection: Axis.horizontal,
                        ),
                        items: sessions.map((session) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(16),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 3.0, vertical: 16),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: new BorderRadius.all(
                                    Radius.circular(cardBorderRadius),
                                  ),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 4,
                                      blurRadius: 5,
                                      offset: Offset(
                                          0, 4), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        session["title"],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: textPrimaryColor),
                                      ),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      child: SvgPicture.asset(
                                          session["image_path"]),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: RoundedButton(
                                        text: "START",
                                        press: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                              return InstructionScreen(
                                                sessionId: session["id"],
                                                title: session["title"],
                                              );
                                            }),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: sessions.map((session) {
                        int index = session["id"] - 1;
                        return Container(
                          width: 8.0,
                          height: 8.0,
                          margin: EdgeInsets.fromLTRB(8, 0, 8, 24),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _current == index
                                ? Color.fromRGBO(0, 0, 0, 0.9)
                                : Color.fromRGBO(0, 0, 0, 0.2),
                          ),
                        );
                      }).toList(),
                    )
                  ]);
            } else {
              return Text("");
            }
          },
        ),
      ),
    );
  }
}

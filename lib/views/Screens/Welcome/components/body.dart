import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:solution_challenge_2021/views/Screens/Login/login_screen.dart';
import 'package:solution_challenge_2021/views/Screens/Signup/signup_screen.dart';
import 'package:solution_challenge_2021/views/components/rounded_button.dart';
import 'package:solution_challenge_2021/views/constants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int _current = 0;
  var _contents = [
    {
      "image": "assets/icons/talk.svg",
      "title": "Welcome to Moodoo",
      "text":
          "We are here to hear you out We are here to hear you out We are here to hear you out"
    },
    {
      "image": "assets/icons/group-chat.svg",
      "title": "Share a story",
      "text":
          "We are here to hear you out We are here to hear you out We are here to hear you out"
    },
    {
      "image": "assets/icons/assessment.svg",
      "title": "Understand mental health",
      "text":
          "We are here to hear you out We are here to hear you out We are here to hear you out"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(child: SizedBox()),
          CarouselSlider(
            options: CarouselOptions(
              height: (MediaQuery.of(context).size.height) * 0.6,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              autoPlayAnimationDuration: Duration(milliseconds: 1600),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
              scrollDirection: Axis.horizontal,
            ),
            items: _contents.map((content) {
              return Builder(
                builder: (BuildContext context) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SvgPicture.asset(
                          content["image"],
                        ),
                      ),
                      Container(
                        width: (MediaQuery.of(context).size.width) * 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              content["title"],
                              style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w500,
                                  color: textPrimaryColor),
                            ),
                            SizedBox(height: 12),
                            Text(
                              content["text"],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w300,
                                  color: textPrimaryColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            }).toList(),
          ),
          Expanded(child: SizedBox()),
          Column(
            children: [
              RoundedButton(
                color: kPrimaryColor,
                text: "LOG IN",
                press: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
                },
              ),
              RoundedButton(
                text: "SIGN UP",
                color: kPrimaryLightColor,
                textColor: Colors.black,
                press: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUpScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

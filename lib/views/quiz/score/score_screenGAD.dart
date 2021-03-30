import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:solution_challenge_2021/models/gad_test.dart';
import 'package:solution_challenge_2021/repositories/gad_dao.dart';
import 'package:solution_challenge_2021/views/constants.dart';
import 'package:solution_challenge_2021/views/quiz/constants.dart';
import 'package:solution_challenge_2021/views/quiz/controllers/question_controllerGAD.dart';
import 'package:solution_challenge_2021/views/quiz/welcome/welcome_screen.dart';

class ScoreScreenGAD extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    QuestionControllerGAD _qnControllerGAD = Get.put(QuestionControllerGAD());
    String report;
    var icon = _qnControllerGAD.totalScore <= 9? "assets/icons/cong.svg" : "assets/icons/cheerup.svg";

    Future<void> storeScore() {
      GAD gad = new GAD(score: _qnControllerGAD.totalScore);
      GadDAO.gadDAO.addTest(gad);
    }


    if (_qnControllerGAD.totalScore<=4) {
      report = "Congratulations! You have minimal anxiety. Keep smiling in the future :)!";
    } else if (_qnControllerGAD.totalScore <= 9 &&
        _qnControllerGAD.totalScore >= 5) {
      report = " You have mild anxiety. Eating delicious food and workout are two most common ways to release anxiety. Keep going!";
    } else if (_qnControllerGAD.totalScore <= 14 &&
        _qnControllerGAD.totalScore >= 10) {
      report = " You have moderate anxiety. Please remember to take a rest amid your busy daily life! Wish you happy days ahead:)";
    } else if (_qnControllerGAD.totalScore <= 21 &&
        _qnControllerGAD.totalScore >= 15) {
      report = " It seems like you are deeply anxious about something. Please take a breath, and trust me, everything is going to be alright:) Let's keep going!";
    } else {
      report = " OOPS! It seems the quiz has some problem. This score is invalid. Please retake the quiz:)";
    }

    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
        future: storeScore(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Text("");
          } else {
            return Scaffold(
              body: SafeArea(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Column(
                      children: [
                        Spacer(flex: 8),
                        SvgPicture.asset(
                            icon
                        ),
                        Spacer(flex: 2),

                        Text(
                          "Anxiety score: ${_qnControllerGAD.totalScore}/21",
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(color: kTextColor),
                        ),
                        Spacer(flex: 1,),
                        Container(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: size.width * 0.8,
                            child: Center(
                              child: Text(
                                "$report",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(color: kTextColor, fontWeight: FontWeight.w300),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Spacer(flex: 3),
                      ],
                    )
                  ],
                ),
              ),
            );

          }
        });

  }
}


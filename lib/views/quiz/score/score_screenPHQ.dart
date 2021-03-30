import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:solution_challenge_2021/models/phq_test.dart';
import 'package:solution_challenge_2021/repositories/phq_dao.dart';
import 'package:solution_challenge_2021/views/quiz/constants.dart';
import 'package:solution_challenge_2021/views/quiz/controllers/question_controllerPHQ.dart';

class ScoreScreenPHQ extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    QuestionControllerPHQ _qnControllerPHQ = Get.put(QuestionControllerPHQ());
    String report;
    var icon = _qnControllerPHQ.totalScore <= 9? "assets/icons/cong.svg" : "assets/icons/cheerup.svg";

    Future<void> storeScore() {
      PHQ phq = new PHQ(score: _qnControllerPHQ.totalScore);
      PhqDAO.phqDAO.addTest(phq);
    }

    if (_qnControllerPHQ.totalScore<=4) {
      report = "Hooray! You have minimal anxiety. Keep smiling in the future :)!";
    } else if (_qnControllerPHQ.totalScore <= 9 &&
    _qnControllerPHQ.totalScore >= 5) {
      report = " You have mild anxiety. Eating delicious food and workout are two most common ways to release anxiety. Keep going!";
    } else if (_qnControllerPHQ.totalScore <= 14 && 
    _qnControllerPHQ.totalScore >= 10) {
      report = " You have moderate anxiety. Please remember to take a rest amid your busy daily life! Wish you happy days ahead:)";
    } else if (_qnControllerPHQ.totalScore <= 19 && 
    _qnControllerPHQ.totalScore >= 15) {
      report = " You have moderately severe depression. Please give yourself a little break. Try your favorite food, go hiking with friends, or just watch the beautiful sunrise tomorrow!";
    } else if (_qnControllerPHQ.totalScore <= 27 && 
    _qnControllerPHQ.totalScore >= 20) {
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
              backgroundColor: Colors.white,
              body: Stack(
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
                        "Anxiety score: ${_qnControllerPHQ.totalScore}/27",
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
            );

          }
        });

  }
}

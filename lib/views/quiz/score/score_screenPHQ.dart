import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solution_challenge_2021/views/quiz/constants.dart';
import 'package:solution_challenge_2021/views/quiz/controllers/question_controllerPHQ.dart';

class ScoreScreenPHQ extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    QuestionControllerPHQ _qnControllerPHQ = Get.put(QuestionControllerPHQ());
    var now = new DateTime.now();
    String report;

    if (_qnControllerPHQ.totalScore<=4) {
      report = "Hooray! You have minimal anxiety. Keep smiling in the future :)!";
    } else if (_qnControllerPHQ.totalScore <= 9 && 
    _qnControllerPHQ.totalScore >= 5) {
      report = " You have mild anxiety. Please try something interesting. Eat delicious food, and do exercise is two most common way to release anxiety. Keep going!";
    } else if (_qnControllerPHQ.totalScore <= 14 && 
    _qnControllerPHQ.totalScore >= 10) {
      report = " You have moderate anxiety. Please remember to take a rest amid your busy daily life! Wish you happy days ahead:)";
    } else if (_qnControllerPHQ.totalScore <= 19 && 
    _qnControllerPHQ.totalScore >= 15) {
      report = " You have moderately severe depression. Please give yourself a little break. Try your favorite food, go hiking with friends, or just watch the beautiful sunrise tomorrow!";
    } else if (_qnControllerPHQ.totalScore <= 27 && 
    _qnControllerPHQ.totalScore >= 20) {
      report = " It seems like you are deeply anxious about something. Please take a breath, and trust me, everything gonna be alright:) Let's keep going!";
    } else {
      report = " OOPS! It seems the quiz has some problem. This score is invalid. Please retake the quiz:)";
    }

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              //Left Space for picture
              Spacer(flex: 18),
              //
              Text(
                "Score: ${_qnControllerPHQ.totalScore}/27",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: kTextColor),
              ),
              Spacer(flex: 1,),
              Center(
                    child: Text(
                      "$now",
                      style: TextStyle(fontSize: 14, color:kTextColor,),      
                    ),
                  ),
              Spacer(flex: 1,),
              Container(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 300.0,
                  height: 100.0,
                
                  child: Center(
                  child: Text(
                      "$report",
                          style: TextStyle(fontSize: 16, color:kTextColor,), 
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
}

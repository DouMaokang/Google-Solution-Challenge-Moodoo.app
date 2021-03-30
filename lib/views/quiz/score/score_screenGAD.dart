import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solution_challenge_2021/views/quiz/constants.dart';
import 'package:solution_challenge_2021/views/quiz/controllers/question_controllerGAD.dart';

class ScoreScreenGAD extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    QuestionControllerGAD _qnControllerGAD = Get.put(QuestionControllerGAD());
    var now = new DateTime.now();
    String report;

    if (_qnControllerGAD.totalScore<=4) {
      report = "Congratulations! You have minimal anxiety. Keep smiling in the future :)!";
    } else if (_qnControllerGAD.totalScore <= 9 && 
    _qnControllerGAD.totalScore >= 5) {
      report = " You have mild anxiety. Please try something interesting. Eat delicious food, and do exercise is two most common way to release anxiety. Keep going!";
    } else if (_qnControllerGAD.totalScore <= 14 && 
    _qnControllerGAD.totalScore >= 10) {
      report = " You have moderate anxiety. Please remember to take a rest amid your busy daily life! Wish you happy days ahead:)";
    } else if (_qnControllerGAD.totalScore <= 21 && 
    _qnControllerGAD.totalScore >= 15) {
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
                "Score: ${_qnControllerGAD.totalScore}/21",
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:solution_challenge_2021/views/components/rounded_button.dart';
import 'package:solution_challenge_2021/views/quiz/constants.dart';
import 'package:solution_challenge_2021/views/quiz/quiz/quiz_screen_GAD.dart';
import 'package:solution_challenge_2021/views/quiz/quiz/quiz_screen_PHQ.dart';

class QuizWelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
//      theme: ThemeData.light(),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Left space for the picture.
                    Padding(padding: EdgeInsets.symmetric(vertical: 32), child: Text(
                      "Find out how you are doing with your mental health",
                      style: Theme.of(context).textTheme.headline5.copyWith(
                          color: kTextColor, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,),),
                    Expanded(child: Container(
                      padding: EdgeInsets.all(12),
                      child: SvgPicture.asset(
                          "assets/icons/assessment.svg"
                      ),
                    ),),
                    Center(
                      child: Text(
                        "Please select the questionnaire you wish to do",
                        style: TextStyle(fontSize: 14, color:kTextColor,),
                      ),
                    ),
                    RoundedButton(
                      text: "PHQ9-9",
                      press: () => Get.to(QuizScreenPHQ())
                    ),
                    RoundedButton(
                        text: "GAD-7",
                        press: () => Get.to(QuizScreenGAD())
                        ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

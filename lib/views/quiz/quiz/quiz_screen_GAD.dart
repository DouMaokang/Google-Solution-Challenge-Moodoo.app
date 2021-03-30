import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solution_challenge_2021/views/quiz/constants.dart';
import 'package:solution_challenge_2021/views/quiz/controllers/question_controllerGAD.dart';

import 'components/bodyGAD.dart';

class QuizScreenGAD extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    QuestionControllerGAD _controllerGAD = Get.put(QuestionControllerGAD());
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: kTextColor),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          FlatButton(onPressed: _controllerGAD.nextQuestion, child: Text("Skip")),
        ],
      ),
      body: BodyGAD(),
    );
  }
}

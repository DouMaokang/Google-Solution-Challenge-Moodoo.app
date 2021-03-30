import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solution_challenge_2021/views/quiz/controllers/question_controllerPHQ.dart';

import 'package:solution_challenge_2021/views/quiz/constants.dart';
import 'components/bodyPHQ.dart';

class QuizScreenPHQ extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QuestionControllerPHQ _controllerPHQ = Get.put(QuestionControllerPHQ());
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: kTextColor),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          FlatButton(onPressed: _controllerPHQ.nextQuestion, child: Text("Skip")),
        ],
      ),
      body: BodyPHQ(),
    );
  }
}

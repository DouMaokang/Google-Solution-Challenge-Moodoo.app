import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solution_challenge_2021/views/constants.dart';
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
        leading: new IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: new Icon(Icons.arrow_back_ios, color: iconPrimaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          FlatButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: _controllerPHQ.nextQuestion, child: Text("Skip")),
        ],
      ),
      body: BodyPHQ(),
    );
  }
}

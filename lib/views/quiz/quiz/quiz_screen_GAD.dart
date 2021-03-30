import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solution_challenge_2021/views/constants.dart';
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
              onPressed: _controllerGAD.nextQuestion,
              child: Text("Skip")),
        ],
      ),
      body: BodyGAD(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solution_challenge_2021/views/quiz/constants.dart';
import 'package:solution_challenge_2021/views/quiz/controllers/question_controllerGAD.dart';
import 'package:solution_challenge_2021/views/quiz/models/QuestionsGAD.dart';

import 'optionGAD.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key key,
    // it means we have to pass this
    @required this.question,
  }) : super(key: key);

  final Question question;

  @override
  Widget build(BuildContext context) {
    QuestionControllerGAD _controllerGAD = Get.put(QuestionControllerGAD());
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        padding: EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            Text(
              question.question,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: kBlackColor),
            ),
            SizedBox(height: kDefaultPadding / 2),
            ...List.generate(
              question.options.length,
              (index) => Option(
                index: index,
                text: question.options[index],
                press: () => _controllerGAD.checkAns(question, index),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

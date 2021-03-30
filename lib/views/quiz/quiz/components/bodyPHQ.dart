import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solution_challenge_2021/views/quiz/constants.dart';
import 'package:solution_challenge_2021/views/quiz/controllers/question_controllerPHQ.dart';

import 'progress_barPHQ.dart';
import 'question_cardPHQ.dart';

class BodyPHQ extends StatelessWidget {
  const BodyPHQ({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // So that we have access our controller
    QuestionControllerPHQ _questionControllerPHQ = Get.put(QuestionControllerPHQ());
    return Stack(
      children: [
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: kDefaultPadding),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Obx(
                  () => Text.rich(
                    TextSpan(
                      text:
                          "Question ${_questionControllerPHQ.questionNumber.value}",
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(color: kSecondaryColor),
                      children: [
                        TextSpan(
                          text: "/${_questionControllerPHQ.questions.length}",
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(color: kSecondaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(thickness: 1.5),
              SizedBox(height: kDefaultPadding),
              Expanded(
                child: PageView.builder(
                  // Block swipe to next qn
                  physics: NeverScrollableScrollPhysics(),
                  controller: _questionControllerPHQ.pageController,
                  onPageChanged: _questionControllerPHQ.updateTheQnNum,
                  itemCount: _questionControllerPHQ.questions.length,
                  itemBuilder: (context, index) => QuestionCard(
                      question: _questionControllerPHQ.questions[index]),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

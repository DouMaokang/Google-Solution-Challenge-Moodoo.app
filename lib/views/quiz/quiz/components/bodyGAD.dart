import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solution_challenge_2021/views/quiz/constants.dart';
import 'package:solution_challenge_2021/views/quiz/controllers/question_controllerGAD.dart';

import 'progress_barGAD.dart';
import 'question_cardGAD.dart';

class BodyGAD extends StatelessWidget {
  const BodyGAD({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // So that we have access our controller
    QuestionControllerGAD _questionControllerGAD = Get.put(QuestionControllerGAD());
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
                          "Question ${_questionControllerGAD.questionNumber.value}",
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(color: kSecondaryColor),
                      children: [
                        TextSpan(
                          text: "/${_questionControllerGAD.questions.length}",
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
                  controller: _questionControllerGAD.pageController,
                  onPageChanged: _questionControllerGAD.updateTheQnNum,
                  itemCount: _questionControllerGAD.questions.length,
                  itemBuilder: (context, index) => QuestionCard(
                      question: _questionControllerGAD.questions[index]),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

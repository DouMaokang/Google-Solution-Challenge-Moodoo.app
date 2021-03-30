//import 'package:flutter/material.dart';
//import 'package:get/get_state_manager/get_state_manager.dart';
//import 'package:solution_challenge_2021/views/quiz/controllers/question_controllerPHQ.dart';
//
//import 'package:solution_challenge_2021/views/quiz/constants.dart';
//
//class ProgressBarPHQ extends StatelessWidget {
//  const ProgressBarPHQ({
//    Key key,
//  }) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      width: double.infinity,
//      height: 35,
//      decoration: BoxDecoration(
//        border: Border.all(color: Color(0xFF3F4768), width: 3),
//        borderRadius: BorderRadius.circular(50),
//      ),
//      child: GetBuilder<QuestionControllerPHQ>(
//        init: QuestionControllerPHQ(),
//        builder: (controller) {
//          return Stack(
//            children: [
//              // LayoutBuilder provide us the available space for the container
//              // constraints.maxWidth needed for our animation
//              LayoutBuilder(
//                builder: (context, constraints) => Container(
//                  // from 0 to 1 it takes 15s
//                  width: constraints.maxWidth * controller.animation.value,
//                  decoration: BoxDecoration(
//                    color: kButtonColor,
//                    borderRadius: BorderRadius.circular(50),
//                  ),
//                ),
//              ),
//              Positioned.fill(
//                child: Padding(
//                  padding: const EdgeInsets.symmetric(
//                      horizontal: kDefaultPadding / 2),
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: [
//                      Text("${(controller.animation.value * 15).round()} sec"),
////                      WebsafeSvg.asset("assets/icons/clock.svg"),
//                    ],
//                  ),
//                ),
//              ),
//            ],
//          );
//        },
//      ),
//    );
//  }
//}

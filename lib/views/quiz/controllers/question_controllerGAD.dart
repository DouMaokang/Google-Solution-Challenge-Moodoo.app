import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:solution_challenge_2021/views/quiz/models/QuestionsGAD.dart';
import 'package:solution_challenge_2021/views/quiz/score/score_screenGAD.dart';

// We use get package for our state management

class QuestionControllerGAD extends GetxController
    with SingleGetTickerProviderMixin {
  // Lets animated our progress bar

  AnimationController _animationController;
  Animation _animation;
  // so that we can access our animation outside
  Animation get animation => this._animation;

  PageController _pageController;
  PageController get pageController => this._pageController;

  List<Question> _questions = sample_data
      .map(
        (question) => Question(
            id: question['id'],
            question: question['question'],
            options: question['options'],),
      )
      .toList();
  List<Question> get questions => this._questions;

  bool _isAnswered = false;
  bool get isAnswered => this._isAnswered;

  int _selectedAns;
  int get selectedAns => this._selectedAns;

  
  RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => this._questionNumber;

  int _totalScore = 0;
  int get totalScore => this._totalScore;

  // called immediately after the widget is allocated memory
  @override
  void onInit() {
    // Our animation duration is 15 s

    _animationController =
        AnimationController(duration: Duration(seconds: 15), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        // update like setState
        update();
      });

    // start our animation
    // Once 15s is completed go to the next qn
    _animationController.forward().whenComplete(nextQuestion);
    _pageController = PageController();
    super.onInit();
  }

  // // called just before the Controller is deleted from memory
  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
  }

  void checkAns(Question question, int selectedIndex) {
    // because once user press any option then it will run
    _isAnswered = true;
    //_correctAns = question.answer;
    _selectedAns = selectedIndex;

    //if (_correctAns == _selectedAns) _numOfCorrectAns++;
    if (_selectedAns == 0) _totalScore+=0;
    if (_selectedAns == 1) _totalScore+=1;
    if (_selectedAns == 2) _totalScore+=2;
    if (_selectedAns == 3) _totalScore+=3;

    // It will stop the counter
    _animationController.stop();
    update();

    // Once user select an ans after 1s it will go to the next qn
    Future.delayed(Duration(seconds: 1), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (_questionNumber.value != _questions.length) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);

      // Reset the counter
      _animationController.reset();

      // Then start it again
      // Once timer is finish go to the next qn
      _animationController.forward().whenComplete(nextQuestion);
    } else {
      // Get package provide us simple way to naviigate another page
      Get.to(ScoreScreenGAD());
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }
}

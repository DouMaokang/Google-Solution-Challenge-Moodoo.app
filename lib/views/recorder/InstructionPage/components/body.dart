import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:solution_challenge_2021/views/recorder/RecordingScreen/recording_screen.dart';

class Body extends StatefulWidget {

  final int sessionId;
  final String title;

  const Body({Key key, this.sessionId, this.title}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  int _currentStep = 0;
  int _totalSteps;
  var _messages;

  @override
  void initState() {
    super.initState();
    setState(() {
      _messages = [
        "Congratulations on making it again today",
        "Find a comfortable space without distractions",
        "Think about your day and tell me about",
        widget.title,
        "Ready? Click to start"
      ];
      _totalSteps = _messages.length;
    });
  }

  void incrementStep() {
    if (_currentStep < _totalSteps) {
      setState(() {
        _currentStep += 1;
      });
    }
  }

  void decrementStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTapUp: (TapUpDetails details) {
          double dx = details.globalPosition.dx;
          double screenWidth = MediaQuery.of(context).size.width;
          if (dx > screenWidth / 2) {
            if (_currentStep == _totalSteps - 1) {
              incrementStep();
              Navigator.of(context).pushReplacement(PageRouteBuilder(
                  pageBuilder: (context, animation, anotherAnimation) {
                    return RecordingScreen(sessionId: widget.sessionId,);
//                    return RecorderPage();
                  },
                  transitionDuration: Duration(milliseconds: 1000),
                  transitionsBuilder:
                      (context, animation, anotherAnimation, child) {
                    animation = CurvedAnimation(
                        curve: Curves.easeIn, parent: animation);
                    return Align(
                      child: FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    );
                  }));

            }
            incrementStep();
          } else {
            if (_currentStep == 0) {
              Navigator.pop(context);
            } else {
              decrementStep();
            }
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: FAProgressBar(
                  direction: Axis.horizontal,
                  size: 4,
                  maxValue: _totalSteps,
                  currentValue: _currentStep,
                  backgroundColor: Colors.grey[200],
                  progressColor: Color(0xffb0e7e1)
              ),
            ),
            Expanded(child:
                Container(
                  margin: EdgeInsets.all(32),
                  alignment: Alignment.center,
                  child: AnimatedSwitcher(duration: Duration(milliseconds: 300),
                  child: _displayedMessage()),
                )
            ),
            Container(
              margin: EdgeInsets.only(bottom: 32),
                child: Text("Tap The Right Side To Continue")
            )
          ],
        ),
      ),
    );
  }
  
  Widget _displayedMessage() {
    if (_currentStep < _totalSteps) {
      return Text(_messages[_currentStep], key: ValueKey<int>(_currentStep), style: TextStyle(fontSize: 26), textAlign: TextAlign.center,);
    } else {
      return Text(_messages[_totalSteps - 1], key: ValueKey<int>(_currentStep), style: TextStyle(fontSize: 26), textAlign: TextAlign.center,);
    }
  }
}

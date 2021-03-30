import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/background.dart';
import 'components/body.dart';

class InstructionScreen extends StatelessWidget {
  final int sessionId;
  final String title;

  const InstructionScreen({Key key, this.sessionId, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Background(
          child: Body(
        sessionId: sessionId,
        title: title,
      )),
    );
  }
}

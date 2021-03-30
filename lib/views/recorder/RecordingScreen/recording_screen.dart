import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/background.dart';
import 'components/body.dart';

class RecordingScreen extends StatelessWidget {
  final int sessionId;

  const RecordingScreen({Key key, this.sessionId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Body(
      sessionId: sessionId,
    ));
  }
}

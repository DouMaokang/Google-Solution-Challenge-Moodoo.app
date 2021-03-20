import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/background.dart';
import 'components/body.dart';

class RecordingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Background(child: Body());
  }
}
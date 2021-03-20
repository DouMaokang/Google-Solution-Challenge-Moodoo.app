import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/background.dart';
import 'components/body.dart';

class InstructionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Background(child: Body()),
    );
  }
}

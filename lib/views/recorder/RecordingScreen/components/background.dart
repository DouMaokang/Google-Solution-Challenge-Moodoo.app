import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_ns/liquid_progress_indicator.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xff2D8CD9),
            Color(0xff36ABEE),
          ],
        ),
      ),
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
              top: -200,
              left: 0,
              child: Container(
                width: MediaQuery.of(context).size.width * 2,
                height: MediaQuery.of(context).size.height * 1.8,
                child: LiquidLinearProgressIndicator(
                  value: 0.25,
                  valueColor: AlwaysStoppedAnimation(
                      const Color(0xffb0e7e1).withOpacity(0.7)),
                  backgroundColor: Colors.transparent,
                  borderWidth: 0,
                  borderRadius: 0,
                  direction: Axis.horizontal,
                  borderColor: Colors.transparent,
                ),
              )),
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 1.2,
                child: LiquidLinearProgressIndicator(
                  value: 0.08,
                  valueColor: AlwaysStoppedAnimation(
                      const Color(0xffb0e7e1).withOpacity(0.8)),
                  backgroundColor: Colors.transparent,
                  borderWidth: 0,
                  borderRadius: 0,
                  direction: Axis.horizontal,
                  borderColor: Colors.transparent,
                ),
              )),
          child,
        ],
      ),
    );
  }
}

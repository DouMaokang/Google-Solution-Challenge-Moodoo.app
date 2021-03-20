import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:solution_challenge_2021/views/constants.dart';

class RecordCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
//      margin: EdgeInsets.only(bottom: 0),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            side: new BorderSide(color: Colors.grey, width: 1.5),
            borderRadius: BorderRadius.circular(cardBorderRadius)
        ),
        color: Colors.white,

        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            children: [
              Column(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Mood',
                        style: TextStyle(
                            color: textPrimaryColor, fontSize: titleFontSize, fontWeight: FontWeight.w600),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '18 Jan, 2021',
                            style: TextStyle(
                                color: textSecondaryColor, fontSize: captionFontSize, fontWeight: FontWeight.normal),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: textSecondaryColor,
                          )
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: SvgPicture.asset(
                      "assets/icons/session-1.svg",
                      height: 120,
                    ),
                  ),
                ],
              ),
              Divider(),
              Text("You have shared what makes you smile today, and we can tell you are happy",
                textAlign: TextAlign.justify,
                style: TextStyle(
                    color: textPrimaryColor, fontSize: secondaryTextFontSize, fontWeight: FontWeight.normal),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

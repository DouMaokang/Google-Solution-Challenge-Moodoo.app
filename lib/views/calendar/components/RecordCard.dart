import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:solution_challenge_2021/models/record.dart';
import 'package:solution_challenge_2021/repositories/session_dao.dart';
import 'package:solution_challenge_2021/utils/DateTimeUtil.dart';
import 'package:solution_challenge_2021/views/constants.dart';

class RecordCard extends StatelessWidget {
  final Record record;

  const RecordCard({Key key, this.record}) : super(key: key);

  String _mapScoreToLevel(double score) {
    if (score == null) {
      return "..";
    }
    if (score <= 4.0) {
      return "you do not have signs of depression. Keep it up :)";
    } else if (score <= 9.0) {
      return "you may have mild depression. Eating well and doing regular exercise can help you concentrate, sleep and feel better. Keep it going!";
    } else if (score <= 14) {
      return "you may have moderate depression. Please remember to take a break amid your busy daily life! A change of pace is good for your mental health. Wish you happy days ahead :)";
    } else if (score <= 19) {
      return "you are deeply anxious about something. Please take a breath, and trust me, everything is going to be alright :) Try doing something you are good at and talk to your best friends.";
    } else {
      return "you may have servere depression. If things are getting too much for you, ask for help. Seeking help from mental health professionals is the easiest way to get better. ";
    }
  }

  @override
  Widget build(BuildContext context) {
    Future _session = SessionDAO.sessionDAO.getSession(record.sessionId);
    var _level = _mapScoreToLevel(record.score);

    DateTime date =
        new DateTime.fromMillisecondsSinceEpoch(record.datetimeCreated * 1000);
    String dateString = DateTimeUtil.dateToString(date);
    return Container(
      margin: EdgeInsets.only(bottom: 2),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            side: new BorderSide(color: Colors.grey, width: 1.5),
            borderRadius: BorderRadius.circular(cardBorderRadius)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Mood',
                        style: TextStyle(
                            color: textPrimaryColor,
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.w600),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${dateString}',
                            style: TextStyle(
                                color: textSecondaryColor,
                                fontSize: captionFontSize,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ],
                  ),
                  FutureBuilder(
                      future: _session,
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasError) {
                          return Text("");
                        } else if (snapshot.hasData) {
                          print(snapshot.data);
                          return Center(
                              child: SvgPicture.asset(
                            snapshot.data.imagePath,
                            height: 120,
                          ));
                        } else {
                          return Text("");
                        }
                      }),
                ],
              ),
              Divider(),
              FutureBuilder(
                  future: _session,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasError) {
                      return Text("");
                    } else if (snapshot.hasData) {
                      return Text(
                        "You have shared ${snapshot.data.title.toLowerCase()}, and we can tell ${_level.toLowerCase()}",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            color: textPrimaryColor,
                            fontSize: secondaryTextFontSize,
                            fontWeight: FontWeight.normal),
                      );
                    } else {
                      return Text("");
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

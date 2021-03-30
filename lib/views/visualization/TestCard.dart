import 'package:flutter/material.dart';

class TestCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 0),
      child: SizedBox(
        height: 160,
        width: double.infinity,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          color: const Color(0xffffefa1),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Test',
                                style: TextStyle(
                                    color: const Color(0xff85603f),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '18 Jan, 2021',
                                    style: TextStyle(
                                        color: const Color(0xff9e7540),
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    color: const Color(0xff9e7540),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Text(
                            "Your PTA-5 test result shows you're doing great with your mental health",
                            style: TextStyle(
                                color: const Color(0xff9e7540),
                                fontSize: 16,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      Divider(),
                      Icon(
                        Icons.face_outlined,
                        size: 42,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:crm/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChartContainer extends StatelessWidget {
  final Color color;
  final String title;
  final Widget chart;

  const ChartContainer({
    Key? key,
    required this.title,
    required this.color,
    required this.chart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 650,
      height: 400,
      // width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.fromLTRB(0, 10, 20, 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                  color: kColorDarkBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: chart,
            )
          ],
        ),
      ),
    );
  }
}

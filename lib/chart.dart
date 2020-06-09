import 'dart:math';

import 'package:flutter/material.dart';

// like layout
class BorrowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 48.0, left: 24.0, right: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
//          TODO: all textStyle should be from common file
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text(
                'Borrow',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.3,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text(
                'Overdraft',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.3,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Text(
                'Account one',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.3,
                ),
              ),
            ),
            Container(
              child: Text(
                'Secondary acc information',
                style: TextStyle(
                  fontSize: 14.0,
                  letterSpacing: -0.3,
                  color: Color.fromRGBO(172, 172, 172, 1),
                ),
              ),
            ),
            /// Chart
            Padding(
              padding: EdgeInsets.only(top: 48.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  OverdraftChart(
                    diameter: 214,
                  ),
                ],
              ),
            ),
//          TODO: all text should be from common file
            buildDescriptionUnderChart(
                'Whenever you need to access more than you have in your account, unlock overdraft.'),
            buildButton('Activate overdraft'),
            Divider(
              color: Colors.black,
            ),
            Container(
              padding: EdgeInsets.only(top: 32.0),
              child: Text(
                'Personal loan',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.3,
                ),
              ),
            ),
            /// Chart Loan
            Padding(
              padding: EdgeInsets.only(top: 48.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  LoanChart(
                    diameter: 214,
                  ),
                ],
              ),
            ),
            buildDescriptionUnderChart(
                'You\'ll be notified when you score has improved.'),
            buildButton('View how to improve score'),
            Divider(
              color: Colors.black,
            ),
            Container(
              padding: EdgeInsets.only(top: 32.0),
              child: Text(
                'Other products you might be interested',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.3,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Container buildDescriptionUnderChart(String desc) {
    return Container(
      child: Text(
        desc,
        style: TextStyle(
          fontSize: 16.0,
          color: Color.fromRGBO(137, 138, 141, 1),
        ),
      ),
    );
  }
  Container buildButton(String btnText) {
    return Container(
      padding: EdgeInsets.only(top: 24.0, bottom: 24.0),
      width: double.infinity,
      child: FlatButton(
        color: Colors.black,
        textColor: Colors.white,
        padding: EdgeInsets.all(16.0),
        splashColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
//                  side: BorderSide(color: Colors.red)
        ),
        onPressed: () {
          print(btnText);
        },
        child: Text(
          btnText,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.3,
          ),
        ),
      ),
    );
  }
}

// draw our Overdraft chart. It's like skeleton for our chart
class OverdraftChart extends StatelessWidget {
  final double diameter;

  OverdraftChart({Key key, this.diameter = 200}) : super(key: key);

  String textInside = 'Unlocked overdraft';
  int number = 650000;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          child: CustomPaint(
            painter: PaintGaugeChart(
              lineColor: Color.fromRGBO(234, 234, 234, 1),
              completeColor: Color.fromRGBO(106, 106, 106, 1),
//          PASS overdraft
              number: number,
              width: 20.0,
            ),
            size: Size(diameter, diameter),
          ),
        ),
        Positioned(
          top: 80.0,
          left: 10.0,
          child: Container(
            width: 195,
            child: Column(
              children: <Widget>[
                Text(
                  textInside,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  number.toString().replaceAllMapped(
                      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                      (Match m) => '${m[1]},'),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// draw our Loan chart. It's like skeleton for our chart
class LoanChart extends StatelessWidget {
  final double diameter;
  LoanChart({Key key, this.diameter = 200}) : super(key: key);

  String textInside = 'You are not elegible to request a loan yet';
  int number = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          child: CustomPaint(
            painter: PaintGaugeChart(
              lineColor: Color.fromRGBO(234, 234, 234, 1),
              completeColor: Color.fromRGBO(106, 106, 106, 1),
//          PASS overdraft
              number: 0,
              width: 20.0,
            ),
            size: Size(diameter, diameter),
          ),
        ),
        Positioned(
          top: 80.0,
          left: 10.0,
          child: Container(
            width: 195,
            child: Column(
              children: <Widget>[
                Text(
                  textInside,
                  textAlign: TextAlign.center,
                  style: textInsideStyle,
                ),
                number == 0
                    ? Container()
                    : Text(
                        number.toString().replaceAllMapped(
                            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                            (Match m) => '${m[1]},'),
                        textAlign: TextAlign.center,
                        style: numberInsideStyle,
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  final TextStyle textInsideStyle =
      TextStyle(color: Colors.black, fontSize: 16, letterSpacing: -0.3);
  final TextStyle numberInsideStyle =
      TextStyle(color: Colors.black, fontSize: 30, letterSpacing: -0.3);
}

class PaintGaugeChart extends CustomPainter {
  static const int _maxOverdraft = 3000000;
  Color lineColor;
  Color completeColor;
  double width;
  final int number;

  PaintGaugeChart(
      {this.lineColor, this.completeColor, this.number, this.width});

  _countPercent(overdraft) {
    if (overdraft > _maxOverdraft || overdraft == 0)
      return overdraft = 100 / _maxOverdraft;
    return ((overdraft * 100) / _maxOverdraft);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint baseLine = Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Paint borrow = Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), pi / 1.25,
        2 * pi * (100 / 140), false, baseLine);

    double arcAngle = 2 * pi * (_countPercent(number) / 140);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), pi / 1.25,
        arcAngle, false, borrow);

//  points in chart
    drawPoint(canvas, size, -20.0, 160.0, '0');
    drawPoint(canvas, size, -40.0, 80.0, '500k');
    drawPoint(canvas, size, 0.0, 0.0, '1M');
    drawPoint(canvas, size, 85.0, -35.0, '1,5M');
    drawPoint(canvas, size, 185.0, 0.0, '2M');
    drawPoint(canvas, size, 230.0, 80.0, '2,5M');
    drawPoint(canvas, size, 220.0, 160.0, '3M');
  }

  final TextPainter textPainter = TextPainter(
    textDirection: TextDirection.rtl,
    textAlign: TextAlign.center,
  );

//  TODO: temporary textStyle
  final TextStyle textPointStyle = TextStyle(
      color: Color.fromRGBO(138, 138, 138, 1),
      fontSize: 12,
      letterSpacing: -0.3);

  void drawPoint(Canvas canvas, Size size, positionX, positionY, String text) {
    textPainter.text = TextSpan(style: textPointStyle, text: text);
    textPainter.layout();
    textPainter.paint(canvas, Offset(positionX, positionY));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

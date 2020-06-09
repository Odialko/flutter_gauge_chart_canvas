import 'dart:math';

import 'package:flutter/material.dart';

// like layout
class BorrowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 48.0, left: 24.0, right: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
//          TODO: all text should be from common file
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
//                pass overdraft
                OverdraftChart(overdraft: 580000, diameter: 214,),
              ],
            ),
          ),
//          TODO: all text should be from common file
          Container(
            child: Text(
              'Whenever you need to access more than you have in your account, unlock overdraft.',
              style: TextStyle(
                fontSize: 16.0,
                color: Color.fromRGBO(137, 138, 141, 1),
              ),
            ),
          ),
//          TODO: all buttons should be from common file
//          Row(
//            crossAxisAlignment: CrossAxisAlignment.stretch,
//            children: <Widget>[
//              FlatButton(
//                color: Colors.black,
//                textColor: Colors.white,
//                padding: EdgeInsets.all(16.0),
//                splashColor: Colors.grey,
//                shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.circular(4.0),
////                  side: BorderSide(color: Colors.red)
//                ),
//                onPressed: () {
//                  /*...*/
//                },
//                child: Text(
//                  "Activate overdraft",
//                  style: TextStyle(
//                    fontSize: 16.0,
//                    fontWeight: FontWeight.w600,
//                    letterSpacing: -0.3,
//
//                  ),
//                ),
//              ),
//            ],
//          ),

        ],
      ),
    );
  }
}
// draw our chart
class OverdraftChart extends StatelessWidget {
  static const int _maxOverdraft = 3000000;
  final double diameter;
  final int overdraft;
  const OverdraftChart({Key key, this.overdraft = 1, this.diameter = 200}) : super(key: key);

  _countPercent(overdraft) {
    if (overdraft > _maxOverdraft || overdraft == 0) return overdraft = 100 / _maxOverdraft;
    return ((overdraft * 100) / _maxOverdraft);
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: PaintGaugeChart(
          lineColor: Color.fromRGBO(234, 234, 234, 1),
          completeColor: Color.fromRGBO(106, 106, 106, 1),
          completePercent: _countPercent(overdraft),
          width: 20.0
      ),
      size: Size(diameter, diameter),
    );
  }
}

class PaintGaugeChart extends CustomPainter{
  Color lineColor;
  Color completeColor;
  double completePercent;
  double width;
  PaintGaugeChart({this.lineColor,this.completeColor,this.completePercent,this.width});

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

    Offset center  = Offset(size.width/2, size.height/2);
    double radius  = min(size.width/2,size.height/2);
    canvas.drawArc(
        Rect.fromCircle(center: center,radius: radius),
        pi/1.25,
        2*pi* (100/140),
        false,
        baseLine
    );

    double arcAngle = 2*pi* (completePercent/140);
    canvas.drawArc(
        Rect.fromCircle(center: center,radius: radius),
        pi/1.25,
        arcAngle,
        false,
        borrow
    );
// TextInside chart
    drawText(canvas, size, 'Unlocked overdraft');
    drawOverdraft(canvas, size, '30,000');

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
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.center,
  );

//  TODO: temporary textStyle
  final TextStyle textPainterStyle = TextStyle(
      color: Colors.black,
      fontSize: 16,
      letterSpacing: -0.3);
  final TextStyle textOverdraftStyle = TextStyle(
      color: Colors.black,
      fontSize: 30,
      letterSpacing: -0.3);
  final TextStyle textPointStyle = TextStyle(
      color: Color.fromRGBO(138, 138, 138, 1),
      fontSize: 12,
      letterSpacing: -0.3);

  void drawPoint(Canvas canvas, Size size, positionX, positionY, String text) {
    textPainter.text = TextSpan(style: textPointStyle, text: text);
    textPainter.layout();
    textPainter.paint(canvas, Offset(positionX, positionY));
  }
  void drawText(Canvas canvas, Size size, String text) {
    textPainter.text = TextSpan(style: textPainterStyle, text: text);
    textPainter.layout();
    textPainter.paint(canvas, Offset(40, size.height - 130));
  }
  void drawOverdraft(Canvas canvas, Size size, String text) {
    textPainter.text = TextSpan(style: textOverdraftStyle, text: text);
    textPainter.layout();
    textPainter.paint(canvas, Offset(65, size.height - 110));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

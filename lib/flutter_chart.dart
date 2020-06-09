import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class FlutterChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  FlutterChart(this.seriesList, {this.animate});

  // Creates a [PieChart] with sample data and no transition.
  factory FlutterChart.withSampleData() {
    return FlutterChart(
      _createSampleData(),
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 290,
        height: 240,
        child: Stack(
          children: <Widget>[
            charts.PieChart(
              seriesList,
              animate: animate,
              animationDuration: Duration(seconds: 1),
              defaultRenderer: charts.ArcRendererConfig(
                arcRatio: 0.14,
                startAngle: 4 / 5 * pi,
                arcLength: 7 / 5 * pi,
                strokeWidthPx: 0.0,
                minHoleWidthForCenterContent: 2,
              ),
            ),
    /*            TODO: инести в клас, який буде ділити загальну суму на 6 і починаючи з 0 додавати резудьтат
              TODO: потім зявдятись почерзі з допомогою AnimatedController
*/
            Positioned(
              bottom: 60.0,
              left: 40.0,
              child: Text('0', style: TextStyle(fontSize: 12.0, color: Color.fromRGBO(138, 138, 138, 1)),),
            ),
            Positioned(
              top: 80.0,
              left: 10.0,
              child: Text('500k', style: TextStyle(fontSize: 12.0, color: Color.fromRGBO(138, 138, 138, 1)),),
            ),
            Positioned(
              top: 20.0,
              left: 50.0,
              child: Text('1M', style: TextStyle(fontSize: 12.0, color: Color.fromRGBO(138, 138, 138, 1)),),
            ),
            Positioned(
              top: 0.0,
              left: 130.0,
              child: Text('1.5M', style: TextStyle(fontSize: 12.0, color: Color.fromRGBO(138, 138, 138, 1)),),
            ),
            Positioned(
              top: 20.0,
              right: 50.0,
              child: Text('2M', style: TextStyle(fontSize: 12.0, color: Color.fromRGBO(138, 138, 138, 1)),),
            ),
            Positioned(
              top: 80.0,
              right: 10.0,
              child: Text('2.5M', style: TextStyle(fontSize: 12.0, color: Color.fromRGBO(138, 138, 138, 1)),),
            ),
            Positioned(
              bottom: 60.0,
              right: 30.0,
              child: Text('3M', style: TextStyle(fontSize: 12.0, color: Color.fromRGBO(138, 138, 138, 1)),),
            ),
            Positioned(
              top: 90.0,
              left: 75.0,
              child: Container(
                width: 140,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Unlocked overdraft",
                      textAlign: TextAlign.center,
                      style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    Text(
                      "30,000",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

/// hard coded data
  static List<charts.Series<GaugeSegment, String>> _createSampleData() {
    final data = [
      GaugeSegment('Low', 750000, Color.fromRGBO(106, 106, 106, 1)),
      GaugeSegment('Acceptable', 2250000, Color.fromRGBO(234, 234, 234, 1)),
    ];

    return [
      charts.Series<GaugeSegment, String>(
        id: 'Segments',
        domainFn: (GaugeSegment segment, _) => segment.segment,
        measureFn: (GaugeSegment segment, _) => segment.size,
        colorFn: (GaugeSegment segment, _) =>
            charts.ColorUtil.fromDartColor(segment.seriesColor),
        data: data,
//        radiusPxFn: charts.ConstCornerStrategy(30),
      )
    ];
  }
}

/// Sample data type.
class GaugeSegment {
  final String segment;
  final int size;
  final Color seriesColor;

  GaugeSegment(this.segment, this.size, this.seriesColor);
}



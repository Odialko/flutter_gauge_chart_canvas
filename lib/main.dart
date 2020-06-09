import 'package:flutter/material.dart';
import 'package:flutter_half_pie_chart/chart.dart';
import 'package:flutter_half_pie_chart/flutter_chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter half pie chart',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Scaffold(
//        appBar: AppBar(
//          title: SafeArea(
//            child: Text('Flutter half pie chart'),
//          ),
//        ),
        body: BorrowPage(),
//        body: FlutterChart.withSampleData(),
      ),
    );
  }
}

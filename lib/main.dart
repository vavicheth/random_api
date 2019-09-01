import 'package:flutter/material.dart';
import 'package:random_api/ui/randompage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RandomPage(),
    );
  }
}


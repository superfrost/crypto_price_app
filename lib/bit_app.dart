import 'package:bitcoin_app/pages/home_page.dart';
import 'package:flutter/material.dart';

class BitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}
import 'package:flutter/material.dart';

class CriptoContainer extends StatelessWidget {
  const CriptoContainer({Key key, this.criptoText}) : super(key: key);
  final String criptoText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      margin: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 4.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(8.0)),
      child: Text(criptoText),
    );
  }
}
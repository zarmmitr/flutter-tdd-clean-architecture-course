import '../api/nt.dart' show NumberTrivia;
import 'package:flutter/material.dart' show BuildContext, Center, Column, Container, Expanded, FontWeight, Key, MediaQuery, SingleChildScrollView, StatelessWidget, Text, TextAlign, TextStyle, Widget, required;

class TriviaBox extends StatelessWidget {
  final NumberTrivia numberTrivia;

  const TriviaBox({
    Key? key,
    required this.numberTrivia,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: <Widget>[
          Text(
            numberTrivia.number.toString(),
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Text(
                  numberTrivia.text,
                  style: TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

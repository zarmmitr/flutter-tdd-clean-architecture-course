import 'package:flutter/material.dart' show BuildContext, Center, CircularProgressIndicator, Container, Key, MediaQuery, StatelessWidget, Widget;

class LoadingBox extends StatelessWidget {
  const LoadingBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

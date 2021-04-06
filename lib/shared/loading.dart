import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyan[900],
      child: Center(
        child: SpinKitThreeBounce(
          color: Colors.white,
          size: 30.0,
        ),
      ),
    );
  }
}

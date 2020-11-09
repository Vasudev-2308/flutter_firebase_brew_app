import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[100],
      child: Center(
        child: SpinKitWave(
          color: Colors.red[500],
          size: 70.0,
        ),
      ),
    );
  }
}

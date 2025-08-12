import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  Color pColor;
  CustomProgressIndicator({super.key, this.pColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: pColor,
      ),
    );
  }
}
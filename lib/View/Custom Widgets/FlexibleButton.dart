import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';

class FlexibleButton extends StatelessWidget {
  String btnText;
  VoidCallback func;
  FlexibleButton({super.key, required this.btnText, required this.func});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        color: Constants.BUTTON_COLOR),
      child: TextButton(onPressed: func, child:  FittedBox(child: Text(btnText,style: const TextStyle(color: Colors.white),))),
    );
  }
}
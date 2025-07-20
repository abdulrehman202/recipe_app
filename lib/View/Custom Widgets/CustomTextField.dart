import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';

class CustomTextField extends StatelessWidget {
  String lbl;
  TextInputType textInputType;
  TextEditingController? controller;
  bool hideLsbel;
  
  CustomTextField({super.key, required this.lbl, this.textInputType = TextInputType.name, this.controller, this.hideLsbel = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          hideLsbel?Container(): Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              lbl,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          TextField(
            controller: controller,
            obscureText: textInputType == TextInputType.visiblePassword,
          keyboardType: textInputType,
            decoration: InputDecoration(
              
              hintText: lbl,
              enabledBorder:  OutlineInputBorder(
                    borderSide: BorderSide(color: Constants.GREY_LABEL_COLOR),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Constants.GREY_LABEL_COLOR),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              
            ),
          ),
        ],
      ),
    );
  }
}
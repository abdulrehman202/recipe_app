import 'package:flutter/material.dart';
import 'package:recipe_app/Constants/color_palette.dart';

class CustomTextField extends StatelessWidget {
  String lbl;
  TextInputType textInputType;
  TextEditingController? controller;
  bool hideLsbel;
  FocusNode? focusNode;
  
  CustomTextField({super.key, required this.lbl, this.textInputType = TextInputType.name, this.controller, this.hideLsbel = false,this.focusNode});

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
            focusNode: focusNode,
            controller: controller,
            obscureText: textInputType == TextInputType.visiblePassword,
          keyboardType: textInputType,
            decoration: InputDecoration(
              
              hintText: lbl,
              enabledBorder:  const OutlineInputBorder(
                    borderSide: BorderSide(color: GREY_LABEL_COLOR),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: GREY_LABEL_COLOR),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              
            ),
          ),
        ],
      ),
    );
  }
}
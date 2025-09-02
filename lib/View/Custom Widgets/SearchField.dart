import 'package:flutter/material.dart';
import 'package:recipe_app/Constants/color_palette.dart';

class SearchField extends StatelessWidget {
  TextEditingController controller;
  Function callback;
  SearchField({super.key, required this.controller, required this.callback});
  
  
  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: const EdgeInsets.only(right: 20),
      child: TextField(
        controller: controller,
        onChanged: (value) => callback(value),
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Search recipe',
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color:  GREY_LABEL_COLOR),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color:  GREY_LABEL_COLOR),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color:  GREY_LABEL_COLOR),
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
      ),
    );
  }
}

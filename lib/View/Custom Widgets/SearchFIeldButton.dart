import 'package:flutter/material.dart';
import 'package:recipe_app/Constants/color_palette.dart';

class SearchFieldButton extends StatelessWidget {
  const SearchFieldButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
    margin: const EdgeInsets.symmetric( horizontal: 10),
    child: const TextField(
      enabled: false,
      decoration: InputDecoration(
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
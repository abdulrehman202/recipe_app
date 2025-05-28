import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/View/search_screen.dart';

class SearchFieldButton extends StatelessWidget {
  const SearchFieldButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute( builder: (context)=> SearchScreen(),)),
      child: Container(
      margin: const EdgeInsets.symmetric( horizontal: 10),
      child: TextField(
        enabled: false,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: 'Search recipe',
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Constants.GREY_LABEL_COLOR),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Constants.GREY_LABEL_COLOR),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Constants.GREY_LABEL_COLOR),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
        ),
      ),
    ),
    );
  }
}
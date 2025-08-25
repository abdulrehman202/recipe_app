import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';

class SearchFieldButton extends StatelessWidget {
  const SearchFieldButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        );
  }
}
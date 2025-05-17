import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';

class SeearchField extends StatelessWidget {
  bool enabled;
  SeearchField({super.key, this.enabled = false}); 

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        
        enabled: enabled,
        
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search recipe',
                disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Constants.GREY_LABEL_COLOR),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                enabledBorder:  OutlineInputBorder(
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
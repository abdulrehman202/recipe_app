import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/View/Custom%20Widgets/CustomTextField.dart';
import 'package:recipe_app/View/Custom%20Widgets/DefaultProfileImageWidget.dart';

class ProfileSetupScreen extends StatelessWidget {
  const ProfileSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body()
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              ClipOval(
                child: Image.asset(Constants.BASE_IMG_PATH+Constants.MICKEY_MOUSE_DP, errorBuilder:(ctx, o,st)=> const DefaultProfileImageWidget(),),
              ),
              Container(
                decoration: BoxDecoration(color: Constants.BUTTON_COLOR,borderRadius: BorderRadius.circular(20.0)),
                margin: const EdgeInsets.only(right: 20.0, bottom: 40.0),
                child: const Icon(Icons.add,color: Colors.white,),
              )
            ],
          ),
          CustomTextField(lbl: 'Full Name'),
          CustomTextField(lbl: 'Add bio'),
          FilledButton(onPressed: (){}, child: const Text('Set Profile'))
        ],
      ),
    );
  }
}
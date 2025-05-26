import 'dart:math';

import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/View/review_screen.dart';
import 'package:recipe_app/View/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle commonTextStyle = TextStyle(
      fontFamily: Constants.FONT_NAME,
      fontWeight: FontWeight.w500,
    );
    return MaterialApp(
      title: 'Recipes',
      theme: ThemeData(
          textTheme: TextTheme(
              labelMedium: commonTextStyle.copyWith(
                  fontSize: 14, fontWeight: FontWeight.bold),
              labelSmall: commonTextStyle.copyWith(
                fontSize: 11,
              ),
              headlineLarge: commonTextStyle.copyWith(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              headlineMedium: commonTextStyle.copyWith(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              headlineSmall: commonTextStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
          filledButtonTheme: FilledButtonThemeData(
              style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder( 
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  padding: const WidgetStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
                  backgroundColor:
                      WidgetStatePropertyAll(Constants.BUTTON_COLOR))),
                      floatingActionButtonTheme: FloatingActionButtonThemeData(
                        backgroundColor: Constants.BUTTON_COLOR,
                        shape: const CircleBorder()
                      ),
                      ),
                      
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

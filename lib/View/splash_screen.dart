import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/View/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(Constants.BASE_IMG_PATH + Constants.SPLASH_IMAGE,),fit: BoxFit.fill)
        ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
            crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                      Constants.BASE_IMG_PATH + Constants.CHEF_HAT_ICON),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '100K+ Premium Recipes',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Get\nCooking',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Simple way to find Tasty Recipe',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: FilledButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => const LoginScreen()));
                      },
                      child: Wrap(
                        direction: Axis.horizontal,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              'Start Cooking',
                              style:
                                  Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                          ImageIcon(AssetImage(Constants.BASE_IMG_PATH +
                              Constants.ARROW_RIGHT)),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Provider/add_recipe_provider.dart';
import 'package:recipe_app/Provider/login_provider.dart';
import 'package:recipe_app/Provider/profile_setup_provider.dart';
import 'package:recipe_app/Provider/sign_up_provider.dart';
import 'package:recipe_app/Provider/user_profile_provider.dart';
import 'package:recipe_app/View/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle commonTextStyle = const TextStyle(
      fontWeight: FontWeight.w500,
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:  (context) => SignUpProvider(),),
        ChangeNotifierProvider(create:  (context) => LoginProvider(),),
        ChangeNotifierProvider(create:  (context) => UserProfileSetupProvider(),),
      ],
      child: MaterialApp(
        title: 'Recipes',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: Constants.FONT_NAME,
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
      ),
    );
  }
}

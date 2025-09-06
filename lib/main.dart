import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';
import 'package:recipe_app/View/all_libs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load();

  await Supabase.initialize(
    
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_KEY'] ?? '',
  );
  

  // NotificationService _notificationService = NotificationService();
// await _notificationService.initialise();
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
        ChangeNotifierProvider(
          create: (context) => SignUpProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProfileSetupProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Recipes',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          fontFamily: FONT_NAME,
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
          filledButtonTheme: FilledButtonThemeData(style: _buttonStyle()),
          floatingActionButtonTheme: _floatingActionButtonThemeData(),
        ),
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  FloatingActionButtonThemeData _floatingActionButtonThemeData() {
    return const FloatingActionButtonThemeData(
        backgroundColor: BUTTON_COLOR, shape: CircleBorder());
  }

  ButtonStyle _buttonStyle() {
    return ButtonStyle(        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
        backgroundColor: const WidgetStatePropertyAll(BUTTON_COLOR));
  }
}

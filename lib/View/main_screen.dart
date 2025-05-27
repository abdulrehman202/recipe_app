import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/View/home_screen.dart';
import 'package:recipe_app/View/saved_recipe_screen.dart';
import 'package:recipe_app/View/user_profiel_screen.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});


  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final List<Widget> _screens = [HomeScreen(),SavedRecipeScreen(),Container(),UserProfielScreen(),];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _floatingActionButton(),
      bottomNavigationBar: _bottomNavBar(),
      body: _screens[index],
    );
  }

  Widget _bottomNavBar() {
    Icon iconHome = const Icon(
      Icons.home_outlined,
    );
    Icon iconSave = const Icon(
      Icons.bookmark_border,
    );
    Icon iconNotification = const Icon(
      Icons.notifications_none_outlined,
    );
    Icon iconProfile = const Icon(
      Icons.person_outline_sharp,
    );
    return Container(
      constraints: const BoxConstraints(minHeight: 50),
      child: BottomNavigationBar(
          selectedIconTheme: const IconThemeData(size: 36),
          type: BottomNavigationBarType.fixed,
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          showUnselectedLabels: true,
          unselectedItemColor: Colors.black,
          selectedItemColor: Constants.BUTTON_COLOR,
          items: [
            BottomNavigationBarItem(
                activeIcon: iconHome, icon: iconHome, label: 'Home'),
            BottomNavigationBarItem(
                activeIcon: iconSave, icon: iconSave, label: 'Saved'),
            BottomNavigationBarItem(
                activeIcon: iconNotification,
                icon: iconNotification,
                label: 'Notifications'),
            BottomNavigationBarItem(
                activeIcon: iconProfile, icon: iconProfile, label: 'Profile'),
          ]),
    );
  }

  Widget _floatingActionButton() {
    return ClipOval(
        child: FloatingActionButton(
            backgroundColor: Constants.BUTTON_COLOR,
            onPressed: () {},
            child: const Icon(
              Icons.add,
              color: Colors.white,
            )));
  }
}

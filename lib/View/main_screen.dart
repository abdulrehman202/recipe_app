import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/View/add_recipe_screen.dart';
import 'package:recipe_app/View/home_screen.dart';
import 'package:recipe_app/View/saved_recipe_screen.dart';
import 'package:recipe_app/View/user_profiel_screen.dart';

class MainScreen extends StatefulWidget {
  String uid;
  MainScreen({super.key, required this.uid});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final List<Widget> _screens;
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _screens = [
      HomeSreen(uid: widget.uid,),
      SavedRecipeScreen(uid: widget.uid,),
      Container(),
      UserProfielScreen(uid: widget.uid),
    ];
  }

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
    double fontSize = 10;
    ImageIcon iconHome = ImageIcon(
      AssetImage(Constants.BASE_IMG_PATH + Constants.HOME_ICON),
    );
    ImageIcon iconSave = ImageIcon(
      AssetImage(Constants.BASE_IMG_PATH + Constants.SAVE_ICON),
    );
    ImageIcon iconNotification = ImageIcon(
      AssetImage(Constants.BASE_IMG_PATH + Constants.NOTIFICATION_ICON),
    );
    ImageIcon iconProfile = ImageIcon(
      AssetImage(Constants.BASE_IMG_PATH + Constants.PROFILE_ICON),
    );
    return Container(
      constraints: const BoxConstraints(minHeight: 75),
      child: BottomNavigationBar(
          unselectedFontSize: fontSize,
          selectedFontSize: fontSize,
          selectedIconTheme: const IconThemeData(size: 36),
          type: BottomNavigationBarType.fixed,
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          showUnselectedLabels: false,
          showSelectedLabels: true,
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
            onPressed: () async {
              await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => AddRecipeScreen()))
                  .whenComplete(() {
                setState(() {
                  index = 3;
                });
              });
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            )));
  }
}

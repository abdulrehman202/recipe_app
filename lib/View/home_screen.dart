import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/View/Custom%20Widgets/RecipeCard.dart';
import 'package:recipe_app/View/Custom%20Widgets/SearchField.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  List<String> _listCategories = [
    'All',
    'Indian',
    'Italian',
    'Asian',
    'Chinese',
    'Turkish',
    'Continental',
    'Fast Food',
  ];

  int _selectedCAtegory = 0;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _floatingActionButton(),
      bottomNavigationBar: _bottomNavBar(),
      body: _body(),
    );
  }

  Widget titleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Wrap(
          direction: Axis.vertical,
          children: [
            Text(
              'Hello Jegga!',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.black),
            ),
            Text(
              'What are you cooking today?',
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(fontSize: 16),
            )
          ],
        ),
        GestureDetector(
            onTap: () {},
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: Constants.BITMOJI_COLOR,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Image.asset(
                Constants.BASE_IMG_PATH + Constants.BITMOJI_IMAGE,
                fit: BoxFit.fill,
              ),
            ))
      ],
    );
  }

  Widget _body() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleRow(),
              searchRow(),
              categories(),
              recipes(),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'New Recipes',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: Colors.black, fontSize: 25),
                  ))
            ],
          ),
        ),
      ),
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

  Widget searchRow() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 50,
      child: Row(
        children: [
          Expanded(child: SeearchField()),
          GestureDetector(
              child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Constants.BUTTON_COLOR,
                      borderRadius: BorderRadius.circular(10)),
                  child: ImageIcon(
                    AssetImage(
                      Constants.BASE_IMG_PATH + Constants.FILTER_ICON,
                    ),
                    color: Colors.white,
                  )))
        ],
      ),
    );
  }

  Widget categories() {
    return SizedBox(
        height: 75,
        child: ChipsChoice<int>.single(
          value: widget._selectedCAtegory,
          onChanged: (val) => setState(() => widget._selectedCAtegory = val),
          choiceItems: C2Choice.listFrom<int, String>(
            source: widget._listCategories,
            value: (i, v) => i,
            label: (i, v) => v,
            tooltip: (i, v) => v,
          ),
          choiceStyle: C2ChipStyle.filled(
            color: Colors.white,
            selectedStyle: C2ChipStyle(
              backgroundColor: Constants.BUTTON_COLOR,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ));
  }

  Widget _floatingActionButton() {
    return ClipOval(
        child: FloatingActionButton(
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: Constants.BUTTON_COLOR,
            onPressed: () {}));
  }

  Widget recipes() {
    return SizedBox(
      height: 300,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, i) {
            return const RecipeCard();
          }),
    );
  }
}

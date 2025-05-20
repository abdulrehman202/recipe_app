import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/View/Custom%20Widgets/RecentRecipeCard.dart';
import 'package:recipe_app/View/Custom%20Widgets/RecipeCard.dart';
import 'package:recipe_app/View/Custom%20Widgets/SearchFIeldButton.dart';
import 'package:recipe_app/View/Custom%20Widgets/SearchField.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  final List<String> _listCategories = [
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
  @override
  Widget build(BuildContext context) {
    return _body();
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
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal:  5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleRow(),
            searchRow(),
            categories(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     recipes(),
              Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'New Recipes',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: Colors.black, fontSize: 25),
                  )),
                  recentRecipes(),
                  ],
                ),
              ),
            ),
           
          ],
        ),
      ),
    );
  }

  Widget searchRow() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 50,
      child: Row(
        children: [
          Expanded(child: SearchFieldButton()),
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
    return ChipsChoice<int>.single(
      
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
    );
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
  
  Widget recentRecipes()
  {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        padding: EdgeInsets.zero,
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, i) {
            return const RecentRecipeCard();
          }),
    );
  }
}

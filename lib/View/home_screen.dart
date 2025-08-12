import 'package:async/async.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Model/Recipe.dart';
import 'package:recipe_app/Provider/home_screen_provider.dart';
import 'package:recipe_app/View/Custom%20Widgets/CustomProgressIndicator.dart';
import 'package:recipe_app/View/Custom%20Widgets/NoRecipeWidget.dart';
import 'package:recipe_app/View/Custom%20Widgets/RecentRecipeCard.dart';
import 'package:recipe_app/View/Custom%20Widgets/RecipeCard.dart';
import 'package:recipe_app/View/Custom%20Widgets/SearchFIeldButton.dart';
import 'package:recipe_app/View/recipe_view_screen.dart';

class HomeScreen extends StatelessWidget {
  String uid;

  late AsyncMemoizer _memoizer;
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

  HomeScreen({super.key, required this.uid});
  @override
  Widget build(BuildContext context) {
    
    _memoizer = AsyncMemoizer();
    return ChangeNotifierProvider(create:  (context) => HomeScreenProvider(),child: Consumer<HomeScreenProvider>(
          builder: (context, provider, _)=>FutureBuilder(
            future: _memoizer.runOnce(()
            async {
              await provider.fetchRecipes(uid);
            }),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.done)
              {
                return snapshot.hasError?Container(): _body(context, provider); 
              }
              return CustomProgressIndicator();
            }
          )));
  }

  Widget titleRow(BuildContext context, HomeScreenProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Wrap(
          direction: Axis.vertical,
          children: [
            Text(
              'Hello ${provider.me?.name??''}!',
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

  Widget _body(BuildContext context, HomeScreenProvider provider) { 
    return SafeArea(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal:  5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleRow(context, provider),
                searchRow(),
                categories(provider),
                provider.listOfRecipes.isEmpty?const NoRecipeWidget(): Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         recipes(context, provider.viewedRecipes,provider.me!.savedRecipes),
                  Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        'New Recipes',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: Colors.black, fontSize: 25),
                      )),
                      recentRecipes(context, provider.newRecipes, provider),
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
      child: SearchFieldButton(),
    );
  }

  Widget categories(HomeScreenProvider provider) {
    return ChipsChoice<int>.single(
      value: provider.selectedCAtegory,
      onChanged: (val) => provider.changeCategory(val),
      choiceItems: C2Choice.listFrom<int, String>(
        
        source: _listCategories,
        value: (i, v) => i,
        label: (i, v) => v,
        tooltip: (i, v) => v,
      ),
      choiceStyle: C2ChipStyle.filled(
        foregroundColor: Constants.BUTTON_COLOR,
        color: Colors.white,
        selectedStyle: C2ChipStyle(
          foregroundColor: Colors.white,
          backgroundColor: Constants.BUTTON_COLOR,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget recipes(BuildContext context, List<Recipe> recipes, List<String> savedRecipes) {
    return recipes.isEmpty?Container(): SizedBox(
      height: 300,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: recipes.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, i) {
            return GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (builder)=>RecipeViewScreen(recipe: recipes[i]))),
              child: RecipeCard(recipe:  recipes[i],saved: savedRecipes.contains(recipes[i].id)));
          }),
    );
  }
  
  Widget recentRecipes(BuildContext context, List<Recipe> recipes, HomeScreenProvider provider)
  {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        padding: EdgeInsets.zero,
          itemCount: recipes.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, i) {
            return GestureDetector(
              onTap: ()async{
                Recipe rr = recipes[i];
                provider.updateView(recipes[i]);
                await provider.addToViewRecipe();
                Navigator.push(context, MaterialPageRoute(builder: (builder)=>RecipeViewScreen(recipe: rr)));
                },
              child: RecentRecipeCard(recipe: recipes[i]));
          }),
    );
  }
}

import 'package:async/async.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Constants/app_constants.dart';
import 'package:recipe_app/Constants/color_palette.dart';
import 'package:recipe_app/Model/Recipe.dart';
import 'package:recipe_app/Model/User.dart';
import 'package:recipe_app/Provider/home_screen_provider.dart';
import 'package:recipe_app/View/Custom%20Widgets/CustomProgressIndicator.dart';
import 'package:recipe_app/View/Custom%20Widgets/NoRecipeWidget.dart';
import 'package:recipe_app/View/Custom%20Widgets/RecentRecipeCard.dart';
import 'package:recipe_app/View/Custom%20Widgets/RecipeCard.dart';
import 'package:recipe_app/View/Custom%20Widgets/SearchFIeldButton.dart';
import 'package:recipe_app/View/recipe_view_screen.dart';
import 'package:recipe_app/View/search_screen.dart';

class HomeSreen extends StatefulWidget {
  String uid;
  HomeSreen({super.key, required this.uid});

  @override
  State<HomeSreen> createState() => _HomeSreenState();
}

class _HomeSreenState extends State<HomeSreen> {
  late AsyncMemoizer _memoizer;
  List<String> cList = ['All'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cList.addAll( listCategories);
  }

  @override
  Widget build(BuildContext context) {
    _memoizer = AsyncMemoizer();
    return ChangeNotifierProvider(
        create: (context) => HomeScreenProvider(),
        child: Consumer<HomeScreenProvider>(
            builder: (context, provider, _) =>
                FutureBuilder(future: _memoizer.runOnce(() async {
                  await provider.fetchRecipes(widget.uid);
                }), builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return snapshot.hasError
                        ? Container()
                        : _body(context, provider);
                  }
                  return CustomProgressIndicator(
                    pColor:  BUTTON_COLOR,
                  );
                })));
  }

  Widget titleRow(BuildContext context, HomeScreenProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Wrap(
          direction: Axis.vertical,
          children: [
            FittedBox(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text.rich(
                    softWrap: true,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Hello, ',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(fontSize: 16),
                        ),
                        TextSpan(
                          text: '${provider.me?.name ?? ''}!',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: Colors.black, fontSize: 22.0),
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )),
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
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
              color:  BITMOJI_COLOR,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Image.asset(
             BASE_IMG_PATH +  BITMOJI_IMAGE,
            fit: BoxFit.fill,
          ),
        )
      ],
    );
  }

  Widget _body(BuildContext context, HomeScreenProvider provider) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            titleRow(context, provider),
            searchRow(provider.listOfRecipes, provider.allChefsDetails),
            categories(provider),
            provider.listOfRecipes.isEmpty
                ? const NoRecipeWidget()
                : Expanded(
                    child: ListView(
                      children: [
                        recipes(context, provider.viewedRecipes,
                            provider.me!.savedRecipes),
                            provider.myChefsRecipe.isEmpty
                            ? Container()
                            : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        'Chefs you follow',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 25),
                                      )),
                                  recipes(
                                      context, provider.myChefsRecipe, provider.me!.savedRecipes),
                                ],
                              ),
                        provider.newRecipes.isEmpty
                            ? Container()
                            : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        'New Recipes',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 25),
                                      )),
                                  recentRecipes(
                                      context, provider.newRecipes, provider),
                                ],
                              ),

                              
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget searchRow(List<Recipe> list, List<User> usersList) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 50,
      child: GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute( builder: (context)=> SearchScreen(allRecipesList: list, chefsList: usersList,),)),
      child: const SearchFieldButton()),
    );
  }

  Widget categories(HomeScreenProvider provider) {
    return ChipsChoice<int>.single(
      value: provider.selectedCAtegory,
      onChanged: (val) {
        provider.changeCategory(val);
        provider.updateRecipeBasedOnCategory();
      },
      choiceItems: C2Choice.listFrom<int, String>(
        source: cList,
        value: (i, v) => i,
        label: (i, v) => v,
        tooltip: (i, v) => v,
      ),
      choiceStyle: C2ChipStyle.filled(
        foregroundColor:  BUTTON_COLOR,
        color: Colors.white,
        selectedStyle: const C2ChipStyle(
          foregroundColor: Colors.white,
          backgroundColor:  BUTTON_COLOR,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget recipes(
      BuildContext context, List<Recipe> recipes, List<String> savedRecipes) {
    return recipes.isEmpty
        ? Container()
        : SizedBox(
            height: 300,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: recipes.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, i) {
                  return GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => RecipeViewScreen(
                                      recipe: recipes[i],
                                      isSAved:
                                          savedRecipes.contains(recipes[i].id),
                                    )));
                        setState(() {});
                      },
                      child: RecipeCard(
                          recipe: recipes[i],
                          saved: savedRecipes.contains(recipes[i].id)));
                }),
          );
  }

  Widget recentRecipes(
      BuildContext context, List<Recipe> recipes, HomeScreenProvider provider) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: recipes.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, i) {
            
            int chefIndex = provider.allChefsDetails.indexWhere((c)=>c.id == recipes[i].chefId);
            String chefName = provider.allChefsDetails[chefIndex].name;
            return GestureDetector(
                onTap: () async {
                  Recipe rr = recipes[i];

                  await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) =>
                                  RecipeViewScreen(recipe: rr)))
                      .whenComplete(() async {
                    provider.updateView(rr);
                    await provider.addToViewRecipe();
                  });
                  setState(() {
                    
                  });
                },
                child: RecentRecipeCard(recipe: recipes[i],name: chefName));
          }),
    );
  }
}

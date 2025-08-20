import 'dart:ui';

import 'package:async/async.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Model/Recipe.dart';
import 'package:recipe_app/Provider/recipe_view_provider.dart';
import 'package:recipe_app/View/Custom%20Widgets/CustomShimmer.dart';
import 'package:recipe_app/View/Custom%20Widgets/IngredientCard.dart';
import 'package:recipe_app/View/Custom%20Widgets/ProcedureCard.dart';
import 'package:recipe_app/View/Custom%20Widgets/SavedRecipeCard.dart';
import 'package:recipe_app/View/review_screen.dart';

class RecipeViewScreen extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late AsyncMemoizer _memoizer;
  Recipe recipe;
  bool isSAved;
  RecipeViewScreen({super.key, required this.recipe, this.isSAved=false});

  @override
  Widget build(BuildContext context) {
    _memoizer = AsyncMemoizer();
    return ChangeNotifierProvider(
      create:  (context) => RecipeViewProvider(),
      child: Consumer<RecipeViewProvider>(
          builder: (context, recipeView, _)=> Scaffold(
            key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: _appBar(recipeView),
          body: _body(context, recipeView),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, RecipeViewProvider provider) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal:  10.0),
        child:
            CustomScrollView(controller: provider.scrollController, slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: [
                SavedecipeCard(showTitle: false,recipe: recipe,),
                _titleRow(context),
                _userRow(context, provider),
              ],
            ),
          ),
          SliverAppBar(
            backgroundColor: Colors.white,
            leading: Container(),
            pinned: true,
            title: _tabsRow(context, provider),
          ),
          SliverAppBar(
              backgroundColor: Colors.white,
              leading: Container(),
              pinned: true,
              flexibleSpace: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      Icon(Icons.room_service_outlined),
                      Text('1 Serve'),
                    ]),
                    _tabsContent(provider)
                  ],
                ),
              ])),
          _tabsList(provider),

          // _tabsContent(),

          // Column(
          //   children: [
          //     SavedecipeCard(showTitle: false),
          //     _titleRow(context),
          //     _userRow(context),
          //     _tabsRow(),
          //     _tabsContent(),
          //   ],
          // ),
        ]));
  }

  PreferredSizeWidget _appBar(RecipeViewProvider provider) {
    return AppBar(
      actions: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: PopupMenuButton(
            onSelected: (value) => _doSomething(value, provider),
            itemBuilder: (_) => <PopupMenuItem<String>>[
              PopupMenuItem<String>(
                  value: 'Share', child: _popUpMenuTile('Share', Icons.share)),
              PopupMenuItem<String>(
                  value: 'Rate Recipe',
                  child: _popUpMenuTile('Rate Recipe', Icons.star)),
              PopupMenuItem<String>(
                  value: 'Review',
                  child: _popUpMenuTile('Review', Icons.rate_review)),
               PopupMenuItem<String>(
                  value: isSAved?'Unsave':'Save',
                  child:
                      _popUpMenuTile(isSAved?'Unsave':'Save', Icons.bookmark_border_outlined)),
            ],
          ),
        )
      ],
    );
  }

  Widget _popUpMenuTile(String txt, IconData icon) {
    return Row(
      children: [
        Icon(icon),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(txt),
        ),
      ],
    );
  }

  _doSomething(String value, RecipeViewProvider provider) {
    switch (value) {
      case 'Share':
        _share();
        break;

      case 'Rate Recipe':
        _rateRecipe();
        break;

      case 'Review':
        _review();
        break;

      case 'Unsave':
        _unsave(provider);
        break;

      case 'Save':
        _save(provider);
        break;
    }
  }

  void _share() {}

  void _rateRecipe() {}

  void _review() 
  {
    Navigator.push( _scaffoldKey.currentState!.context , MaterialPageRoute(builder: (ctx)=> ReviewScreen(recipeId: recipe.id,)) );
  }

  Future<void> _unsave(RecipeViewProvider provider)
  async{
    provider.removeFromSavedRecipeList(recipe.id);
    await provider.updateSavedrecipes();
    isSAved = false;
  }
  Future<void> _save(RecipeViewProvider provider) async
  {
    provider.addToSavedRecipeList(recipe.id);
    await provider.updateSavedrecipes();
    isSAved = true;
  }

  Widget _titleRow(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(
                  recipe.name,
                  overflow: TextOverflow.clip,
                  style: Theme.of(context).textTheme.labelMedium,
                )),
            Expanded(
                child: Align(
                    alignment: Alignment.centerRight, child: Text('${recipe.totalUsersWhoRated??0} rating(s)')))
          ],
        ),
        Row(
          children: [
            const Icon(Icons.alarm_rounded),
            Container(
              margin: const EdgeInsets.only(left: 5),
              child: Text('${recipe.duration} mins')),
          ],
        )
      ],
    );
  }

  Widget _userRow(BuildContext context, RecipeViewProvider provider) {
    return FutureBuilder(
      future: _memoizer.runOnce(() async {
          await provider.fetchUser(recipe.chefId);
        }),
      builder: (context, asyncSnapshot) {
        if(asyncSnapshot.connectionState == ConnectionState.waiting)
        {
          return Container(
          margin: const EdgeInsets.symmetric(vertical: 30),
            height: 50,
            alignment: Alignment.centerLeft,
            child: userInfoShimmer(
                                
                    Container(
                      color: Colors.white,
                    ),
                  
                              ),)
            // child: const Text('Fetching recipe owner\'s detail...',))
            ;
        }
        else if(asyncSnapshot.connectionState == ConnectionState.done) {
        if(provider.success)
        {
          return Container(
          margin: const EdgeInsets.symmetric(vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 8,
                child: Row(
                  children: [
                    ClipOval(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset(
                          Constants.BASE_IMG_PATH + Constants.DP_IMAGE,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            margin: const EdgeInsets.only(left: 24),
                            child: Text(
                              provider.user!.name,
                              style: Theme.of(context).textTheme.labelMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ), 
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_sharp,
                                color: Constants.BUTTON_COLOR,
                              ),
                              const Text('Faisalabad, Pakistan')
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              provider.myId == recipe.chefId?Container(): Expanded(
                flex: 2,
                  child:
                      GestureDetector(onTap: () {}, child: Container(
                        
                        width: MediaQuery.of(context).size.width*0.1,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                          color: Constants.BUTTON_COLOR
                        ),
                        child: const Text('Follow',style: TextStyle(color: Colors.white), overflow: TextOverflow.fade, ))))
            ],
          ),
        );}}
        else{ Container();}
        return Container();
      }
    );
  }

  Widget _tabsRow(BuildContext context, RecipeViewProvider provider) {
    return ChipsChoice<int>.single(
      scrollToSelectedOnChanged: true,
      mainAxisAlignment: MainAxisAlignment.center,
      padding: EdgeInsets.zero,
      value: provider.selectedPage,
      onChanged: (val) => provider.changePage(val),
      choiceItems: C2Choice.listFrom<int, String>(
        source: ['Ingredients', 'Procedure'],
        value: (i, v) => i,
        label: (i, v) => v,
        tooltip: (i, v) => v,
      ),
      choiceStyle: C2ChipStyle.filled(
        color: Colors.white,
        selectedStyle: C2ChipStyle(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1),
          backgroundColor: Constants.BUTTON_COLOR,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _tabsContent(RecipeViewProvider provider) {
    return Text(provider.selectedPage == 0 ? '${recipe.ingredients.length} items' : '${recipe.procedure.length} steps');
  }

  Widget _tabsList(RecipeViewProvider provider) {
    return SliverList.builder(
            itemBuilder: (BuildContext context, int index) {
              return provider.selectedPage == 0? IngredientCard(ingredient: recipe.ingredients[index],):ProcedureCard(procedure: recipe.procedure[index],);
            },
            itemCount: provider.selectedPage == 0?recipe.ingredients.length:recipe.procedure.length
          );
  }
}

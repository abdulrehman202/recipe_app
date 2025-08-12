import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Provider/saved_recipe_provider.dart';
import 'package:recipe_app/View/Custom%20Widgets/CustomProgressIndicator.dart';
import 'package:recipe_app/View/Custom%20Widgets/SavedRecipeCard.dart';

class SavedRecipeScreen extends StatelessWidget {
  String uid;
  late AsyncMemoizer _memoizer;
  late SavedRecipeProvider provider;
  SavedRecipeScreen({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    _memoizer = AsyncMemoizer();
    return Scaffold( 
      appBar: _appBar(context),
      body: ChangeNotifierProvider(
      create:  (context) => SavedRecipeProvider(),
      child: Consumer<SavedRecipeProvider>(
          builder: (context, provider, _)=> FutureBuilder(future: _memoizer.runOnce(()async
          {
           await provider.fetchRecipes(uid);
          }) , builder: (ctx, snapshot)
      {
        if(snapshot.connectionState == ConnectionState.waiting)
        {
          return CustomProgressIndicator(pColor: Constants.BUTTON_COLOR,);
        }

        return snapshot.hasError?Container():_body(provider);

      }) )));
  }
  
  Widget _body(SavedRecipeProvider provider) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListView.builder(
              physics: const ScrollPhysics(),
              itemCount: provider.listOfRecipes.length,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                return SavedecipeCard(showTitle: true, recipe: provider.listOfRecipes[i],);
              }
            ),
          ],
        ),
      ),
    );
  }
  
  PreferredSizeWidget? _appBar(BuildContext context) 
  {
    return AppBar(
      leading: Container(),
      title: Center(child: Text('Saved Recipes', style: Theme.of(context).textTheme.labelMedium,)),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:recipe_app/View/Custom%20Widgets/SavedRecipeCard.dart';

class SavedRecipeScreen extends StatelessWidget {
  const SavedRecipeScreen({super.key});

  @override
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: _appBar(context),
      body: _body());
  }
  
  Widget _body() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListView.builder(
              physics: const ScrollPhysics(),
              itemCount: 5,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                return const SavedecipeCard();
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
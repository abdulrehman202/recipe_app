import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';

class ChooseCategoryScreen extends StatelessWidget {
  const ChooseCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        onPopInvoked: (didPop) => -1,
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: Constants.listCategories.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(Constants.listCategories[index]),
              onTap: () {
                Navigator.pop(context, index);
              },
            ),
          ),
        ],
            ),
      ),
    );
  }
}

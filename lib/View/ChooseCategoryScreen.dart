import 'package:flutter/material.dart';
import 'package:recipe_app/Constants/app_constants.dart';

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
            itemCount:  listCategories.length,
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.all(10),
              child: ListTile(
                title: Text( listCategories[index]),
                leading: SizedBox(
                  width: 60,
                  height: 60,
                  child: ClipOval(
                    child: Image.asset('${ BASE_IMG_PATH}${ listCategories[index]}.jpeg',fit: BoxFit.fill,)),
                ),
                onTap: () {
                  Navigator.pop(context, index);
                },
              ),
            ),
          ),
        ],
            ),
      ),
    );
  }
}

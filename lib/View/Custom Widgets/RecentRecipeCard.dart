import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';

class RecentRecipeCard extends StatelessWidget {
  const RecentRecipeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      width: 400,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: Card(
              elevation: 10,
              child: Padding(
            padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 250,
                      child: Text(
                        'Classic Greek Salad',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Wrap(
                      children: [
                        for (int i = 0; i < 5; i++)  Icon(Icons.star, color: Constants.YELLOW_LABEL_COLOR,),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 20, bottom: 10, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipOval(
                                child: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Image.asset(Constants.BASE_IMG_PATH+Constants.DP_IMAGE, fit: BoxFit.fill,),
                                ),
                              ),
                                const SizedBox(
                                width: 250,
                                child: Text(' By William',overflow: TextOverflow.ellipsis, ))
                            ],
                          ),
                          const Text('20 min')
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.only(right: 20),
            child: ClipOval(
              child: SizedBox(
                width: 100,
                height: 100,
                child: Image.asset(Constants.BASE_IMG_PATH+Constants.DISH_IMAGE)),
            ),
          )
        ],
      ),
    );
  }
}

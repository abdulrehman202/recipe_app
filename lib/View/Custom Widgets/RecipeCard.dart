import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      width: 150,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                  color: Constants.RECIPE_CARD_COLOR,
                  borderRadius: BorderRadius.circular(20)),
              height: 220,
              width: double.infinity,
              child: Container(
                margin: const EdgeInsets.only(top: 40),
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(
                      'Classic Greek Salad',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(fontSize: 16),
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.center,
                    )),
                    SizedBox(
                      height: 50,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Wrap(
                              direction: Axis.vertical,
                              children: [
                                Text('Time',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(color: Colors.black)),
                                const Text('20min')
                              ],
                            ),
                            ClipOval(
                                child: Container(
                                    padding: const EdgeInsets.all(7.0),
                                    color: Colors.white70,
                                    child: GestureDetector(
                                        onTap: () {},
                                        child:
                                            const Icon(Icons.bookmark_border))))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ClipOval(
              child: Container(
                height: 100,
                width: 100,
                margin: EdgeInsets.only(top: 25),
                decoration: BoxDecoration(color: Constants.BUTTON_COLOR),
                child: Image.asset(
                  Constants.BASE_IMG_PATH + Constants.DISH_IMAGE,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: const EdgeInsets.only(top: 65, right: 10),
              width: 60,
              decoration: BoxDecoration(
                  color: Constants.BITMOJI_COLOR,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: const Row(
                children: [
                  Icon(Icons.star),
                  Text('4.0'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

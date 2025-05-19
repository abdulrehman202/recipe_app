import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';

class SearchResultDishCard extends StatelessWidget {
  const SearchResultDishCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10.0, bottom: 10.0),
      child: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.black,
              ),
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                Constants.BASE_IMG_PATH + Constants.SEARCH_DISH_IMAGE,
                fit: BoxFit.fill,
              )),
          Container(
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              direction: Axis.vertical,
              children: [
                Container(
                    alignment: Alignment.bottomLeft,
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: 100,
                    child: Text(
                      'Traditional spare ribs baked' * 10,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      overflow: TextOverflow.clip,
                    )),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    'By Chef John' * 10,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: const EdgeInsets.all(8.0),
              width: 60,
              decoration: BoxDecoration(
                  color: Constants.BITMOJI_COLOR,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: const Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
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

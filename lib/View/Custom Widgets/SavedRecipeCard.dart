import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';

class SavedecipeCard extends StatelessWidget {
  const SavedecipeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      height: 200,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black, Colors.transparent],
                  stops: [
                    0.0,
                    1.0,
                  ],
                ).createShader(bounds);
              },
              blendMode: BlendMode.darken,
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image.asset(
                  Constants.BASE_IMG_PATH + Constants.SEARCH_DISH_IMAGE,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Wrap(
                  direction: Axis.vertical,
                  children: [
                    Container(
                        alignment: Alignment.bottomLeft,
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 70,
                        child: Text(
                          'Traditional spare ribs baked',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                          overflow: TextOverflow.clip,
                        )),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 30,
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'By Chef John',
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
                ClipOval(
                    child: Container(
                        padding: const EdgeInsets.all(7.0),
                        color: Colors.white,
                        child: GestureDetector(
                            onTap: () {},
                            child: const Icon(Icons.bookmark_border)))),
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

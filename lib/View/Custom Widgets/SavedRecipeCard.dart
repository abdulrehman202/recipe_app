import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Model/Recipe.dart';
import 'package:recipe_app/View/recipe_view_screen.dart';

class SavedecipeCard extends StatefulWidget {
  Recipe recipe;
  bool showTitle;

  SavedecipeCard({super.key,this.showTitle = true, required this.recipe});

  @override
  State<SavedecipeCard> createState() => _SavedecipeCardState();
}

class _SavedecipeCardState extends State<SavedecipeCard> {

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => widget.showTitle? Navigator.push(context, MaterialPageRoute(builder: (context)=>RecipeViewScreen())):(){},
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        height: MediaQuery.of(context).size.height*0.2,
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
                    fit: BoxFit.cover,
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
                   widget.showTitle? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        flex: 3,
                        child: SizedBox()),
                      Expanded(
                        flex: 5,
                        child: Container(
                            alignment: Alignment.bottomLeft,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              widget.recipe.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                              overflow: TextOverflow.clip,
                            )),
                      ),
                      !widget.showTitle? Container(): Expanded(
                        flex: 2,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            '',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                    ],
                  ):Container(),
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
      ),
    );
  }
}

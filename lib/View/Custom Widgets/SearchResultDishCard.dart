import 'package:recipe_app/View/all_libs.dart';

class SearchResultDishCard extends StatelessWidget {
  Recipe recipe;
  String name;
  SearchResultDishCard({super.key, required this.recipe, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10.0, bottom: 10.0),
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
                   BASE_IMG_PATH +  SEARCH_DISH_IMAGE,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
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
                      recipe.name,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      overflow: TextOverflow.clip,
                    )),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    'By $name',
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
              decoration: const BoxDecoration(
                  color:  BITMOJI_COLOR,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child:  Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Text(  getNetRating(recipe.totalRating,recipe.usersWhoRated.length).toString().padRight(2,'.0') ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

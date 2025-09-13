import 'package:recipe_app/View/all_libs.dart';

class RecentRecipeCard extends StatelessWidget {
  Recipe recipe;
  String name, pic;
  RecentRecipeCard({super.key, required this.recipe, required this.name, required this.pic}); 

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
        width: MediaQuery.of(context).size.width*0.7,
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
                      width: (MediaQuery.of(context).size.width*0.7) - 120,
                      child: Text(
                        recipe.name,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      child: Wrap(
                        children: [
                          for (int i = 0; i <  getNetRating(recipe.totalRating ,recipe.usersWhoRated.length).toInt() ; i++)  Icon(Icons.star, color:  YELLOW_LABEL_COLOR,),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 20, bottom: 10, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 7,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipOval(
                                  child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: CustomImageWidget(imgUrl: pic),
                                  ),
                                ),
                                   Expanded(child: Text(' By $name',overflow: TextOverflow.ellipsis, ))
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text('${recipe.duration} min', textAlign: TextAlign.end,))
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
            margin: const EdgeInsets.only(right: 10),
            child: ClipOval(
              child: SizedBox(
                width: 100,
                height: 100,
                child: CustomImageWidget(imgUrl: recipe.imgUrl),)
            ),
          )
        ],
      ),
    );
  }
}

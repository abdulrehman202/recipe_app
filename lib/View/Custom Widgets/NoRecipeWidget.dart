import 'package:recipe_app/View/all_libs.dart';

class NoRecipeWidget extends StatelessWidget {
  const NoRecipeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Image.asset(
          BASE_IMG_PATH + NO_RECIPE_IMAGE,
          fit: BoxFit.fill,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(NO_RECIPE_MSG,
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: Colors.black, fontSize: 20))
      ],
    ));
  }
}
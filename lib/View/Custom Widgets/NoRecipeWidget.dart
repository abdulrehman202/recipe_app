import 'package:recipe_app/View/all_libs.dart';

class NoRecipeWidget extends StatelessWidget {
  const NoRecipeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text(NO_RECIPE_MSG),); 
  }
}
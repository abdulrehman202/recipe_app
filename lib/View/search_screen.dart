import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Model/Recipe.dart';
import 'package:recipe_app/Model/User.dart';
import 'package:recipe_app/View/Custom%20Widgets/FilterSheet.dart';
import 'package:recipe_app/View/Custom%20Widgets/SearchField.dart';
import 'package:recipe_app/View/Custom%20Widgets/SearchResultDishCard.dart';
import 'package:recipe_app/View/recipe_view_screen.dart';

class FilterParams {
  int? selectedRating;
  List<int> selectedCategories;

  FilterParams(this.selectedRating, this.selectedCategories);
}

class SearchScreen extends StatefulWidget {
  List<Recipe> allRecipesList;
  List<User> chefsList;
  SearchScreen({super.key, required this.allRecipesList, required this.chefsList});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController txtController = TextEditingController();
  List<Recipe> searchResultList = [];

  FilterParams filterResultObl = FilterParams(0, []);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Center(
            child: Text(
          'Search Recipe',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.black, fontSize: 18),
        )),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [searchRow(), searchResults()],
      ),
    );
  }

  Widget searchRow() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 50,
      child: Row(
        children: [
          Expanded(
              child: SearchField(
            controller: txtController,
            callback: (s) {
              List<Recipe> temp = widget.allRecipesList
                  .where((r) =>
                      r.name.toLowerCase().contains(s.toString().toLowerCase()))
                  .toList();
              setState(() {
                searchResultList = temp;
              });
            },
          )),
          Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: Constants.BUTTON_COLOR,
                  borderRadius: BorderRadius.circular(10)),
              child: GestureDetector(
                onTap: () async {
                  var result = await showModalBottomSheet(
                      context: _scaffoldKey.currentState!.context,
                      builder: (context) => FilterSheet(
                          selectedRating: filterResultObl.selectedRating,
                          selectedCategory: filterResultObl.selectedCategories),
                      enableDrag: true,
                      isScrollControlled: true);

                  filterResultObl.selectedRating = result[0];
                  filterResultObl.selectedCategories = result[1];

                  List<Recipe> temp = widget.allRecipesList;

                  if (filterResultObl.selectedRating != null) {
                    temp = temp
                        .where((r) =>
                            Constants.getNetRating(
                                r.totalRating, r.usersWhoRated.length) >=
                            filterResultObl.selectedRating! + 1)
                        .toList();
                  }

                  if (filterResultObl.selectedCategories.isNotEmpty) {
                    temp = temp
                        .where((r) => filterResultObl.selectedCategories
                            .contains(r.categoryId))
                        .toList();
                  }

                  setState(() {
                    searchResultList = temp;
                  });
                },
                child: ImageIcon(
                  AssetImage(
                    Constants.BASE_IMG_PATH + Constants.FILTER_ICON,
                  ),
                  color: Colors.white,
                ),
              ))
        ],
      ),
    );
  }

  Widget searchResults() {
    double margin = 5.0;
    return Flexible(
      child: GridView.builder(
          shrinkWrap: true,
          itemCount: searchResultList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (c, i) {
            
            int chefIndex = widget.chefsList.indexWhere((c)=>c.id == searchResultList[i].chefId);
            String chefName = widget.chefsList[chefIndex].name;
            return Container(
                margin: i % 2 == 0
                    ? EdgeInsets.only(bottom: margin, right: margin)
                    : EdgeInsets.only(bottom: margin, left: margin),
                child: GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) =>
                                RecipeViewScreen(recipe: searchResultList[i]))),
                    child: SearchResultDishCard(recipe: searchResultList[i], name: chefName)));
          }),
    );
  }
}

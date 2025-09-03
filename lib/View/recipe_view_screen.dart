import 'package:recipe_app/View/all_libs.dart';

class RecipeViewScreen extends StatelessWidget {
  final GlobalKey<ShakeWidgetState> keyShake = GlobalKey<ShakeWidgetState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late AsyncMemoizer _memoizer;
  Recipe recipe;
  bool isSAved;
  RecipeViewScreen({super.key, required this.recipe, this.isSAved = false});

  @override
  Widget build(BuildContext context) {
    _memoizer = AsyncMemoizer();
    return ChangeNotifierProvider(
      create: (context) => RecipeViewProvider(),
      child: Consumer<RecipeViewProvider>(
        builder: (context, recipeView, _) => Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: _appBar(recipeView),
          body: _body(context, recipeView),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, RecipeViewProvider provider) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        child: CustomScrollView(
            controller: provider.scrollController,
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SavedecipeCard(
                      showTitle: false,
                      recipe: recipe,
                    ),
                    _titleRow(context),
                    _userRow(context, provider),
                  ],
                ),
              ),
              SliverAppBar(
                backgroundColor: Colors.white,
                leading: Container(),
                pinned: true,
                title: _tabsRow(context, provider),
              ),
              SliverAppBar(
                  backgroundColor: Colors.white,
                  leading: Container(),
                  pinned: true,
                  flexibleSpace: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(Icons.room_service_outlined),
                              Text('1 Serve'),
                            ]),
                        _tabsContent(provider)
                      ],
                    ),
                  ])),
              _tabsList(provider),

              // _tabsContent(),

              // Column(
              //   children: [
              //     SavedecipeCard(showTitle: false),
              //     _titleRow(context),
              //     _userRow(context),
              //     _tabsRow(),
              //     _tabsContent(),
              //   ],
              // ),
            ]));
  }

  PreferredSizeWidget _appBar(RecipeViewProvider provider) {
    return AppBar(
      actions: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: PopupMenuButton(
            onSelected: (value) => _doSomething(value, provider),
            itemBuilder: (_) => <PopupMenuItem<String>>[
              PopupMenuItem<String>(
                  value: SHARE, child: _popUpMenuTile(SHARE, Icons.share)),
              PopupMenuItem<String>(
                  value: RATE,
                  child: _popUpMenuTile(RATE, Icons.star)),
              PopupMenuItem<String>(
                  value: REVIEW,
                  child: _popUpMenuTile(REVIEW, Icons.rate_review)),
              PopupMenuItem<String>(
                  value: isSAved ? UNSAVE : SAVE,
                  child: _popUpMenuTile(isSAved ? UNSAVE : SAVE,
                      Icons.bookmark_border_outlined)),
            ],
          ),
        )
      ],
    );
  }

  Widget _popUpMenuTile(String txt, IconData icon) {
    return Row(
      children: [
        Icon(icon),
        Padding(
          padding: const EdgeInsets.only(left: 10), 
          child: Text(txt),
        ),
      ],
    );
  }

  _doSomething(String value, RecipeViewProvider provider) {
    switch (value) {
      case SHARE:
        _share();
        break;

      case RATE:
        _rateRecipe(provider);
        break;

      case REVIEW:
        _review();
        break;

      case UNSAVE:
        _unsave(provider);
        break;

      case SAVE:
        _save(provider);
        break;
    }
  }

  void _share() {}

  void _rateRecipe(RecipeViewProvider provider) {
    late Rating previousRating;
    late int indexOfPreviousRating = 0;
    bool alreadyRated = recipe.usersWhoRated
        .where((r) => r.uid.contains(provider.myId))
        .isNotEmpty;
    List<String> ratingComments = [
      POOR,
      B_AVERGAE,
      AVERAGE,
      GOOD,
      EXCELLENT,
    ];

    if (alreadyRated) {
      indexOfPreviousRating =
          recipe.usersWhoRated.indexWhere((r) => r.uid.contains(provider.myId));
      previousRating = recipe.usersWhoRated[indexOfPreviousRating];
    } else {
      previousRating = Rating(provider.myId, 0);
    }
    provider.rating = previousRating.rating as double;

    showDialog(
      context: _scaffoldKey.currentState!.context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: alreadyRated
                  ? Container()
                  : Text(
                      'Rate this Recipe',
                      style: Theme.of(_scaffoldKey.currentState!.context)
                          .textTheme
                          .displaySmall!
                          .copyWith(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                    ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ShakeAnimatedWidget(
                    key: keyShake,
                    shakeCount: 3,
                    shakeOffset: 10,
                    shakeDuration: const Duration(milliseconds: 500),
                    child: StarRating(
                      size: 40.0,
                      rating: provider.rating,
                      color:  YELLOW_LABEL_COLOR,
                      borderColor: Colors.grey,
                      starCount: 5,
                      onRatingChanged: (rating) => setState(() {
                        provider.updateRating(rating);
                      }),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  provider.rating == 0
                      ? Container()
                      : Text(
                          ratingComments[provider.rating.toInt() - 1],
                          style: Theme.of(_scaffoldKey.currentState!.context)
                              .textTheme
                              .labelMedium,
                        ),
                ],
              ),
              actions: [
                FilledButton(
                    onPressed: () async {
                      if (alreadyRated) {
                        recipe.totalRating -=
                            recipe.usersWhoRated[indexOfPreviousRating].rating;
                        recipe.usersWhoRated[indexOfPreviousRating].rating =
                            provider.rating as int;
                        recipe.totalRating += provider.rating as int;
                      } else {
                        recipe.usersWhoRated.add(previousRating);
                      }
                      await provider.rateRecipe(recipe);
                      Navigator.pop(_scaffoldKey.currentState!.context);
                    },
                    child: Center(
                        child: provider.loading
                            ? CustomProgressIndicator()
                            : const Text('Submit')))
              ],
            );
          },
        );
      },
    );
  }

  void _review() {
    Navigator.push(
        _scaffoldKey.currentState!.context,
        MaterialPageRoute(
            builder: (ctx) => ReviewScreen(
                  recipeId: recipe.id,
                )));
  }

  Future<void> _unsave(RecipeViewProvider provider) async {
    provider.removeFromSavedRecipeList(recipe.id);
    await provider.updateSavedrecipes();
    isSAved = false;
  }

  Future<void> _save(RecipeViewProvider provider) async {
    provider.addToSavedRecipeList(recipe.id);
    await provider.updateSavedrecipes();
    isSAved = true;
  }

  Widget _titleRow(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(
                  recipe.name,
                  overflow: TextOverflow.clip,
                  style: Theme.of(context).textTheme.labelMedium,
                )),
            Expanded(
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text('${recipe.usersWhoRated.length} rating(s)')))
          ],
        ),
        Row(
          children: [
            const Icon(Icons.alarm_rounded),
            Container(
                margin: const EdgeInsets.only(left: 5),
                child: Text('${recipe.duration} mins')),
          ],
        )
      ],
    );
  }

  Widget _userRow(BuildContext context, RecipeViewProvider provider) {
    return FutureBuilder(future: _memoizer.runOnce(() async {
      await provider.fetchUser(recipe.chefId);
    }), builder: (context, asyncSnapshot) {
      if (asyncSnapshot.connectionState == ConnectionState.waiting) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 30),
          height: 50,
          alignment: Alignment.centerLeft,
          child: userInfoShimmer(
            Container(
              color: Colors.white,
            ),
          ),
        )
            // child: const Text('Fetching recipe owner\'s detail...',))
            ;
      } else if (asyncSnapshot.connectionState == ConnectionState.done) {
        if (provider.success) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 7,
                  child: Row(
                    children: [
                      ClipOval(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.asset(
                             BASE_IMG_PATH +  DP_IMAGE,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 24),
                              child: Text(
                                provider.chef!.name,
                                style: Theme.of(context).textTheme.labelMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Row(
                              children: [
                                Icon(
                                  Icons.location_on_sharp,
                                  color:  BUTTON_COLOR,
                                ),
                                Text('Faisalabad, Pakistan')
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                provider.myId == recipe.chefId
                    ? Container()
                    : Expanded(
                        flex: 3,
                        child: GestureDetector(
                            onTap: () async {
                              await provider.followThisChef(recipe.chefId);
                            },
                            child: Container(
                                // width: MediaQuery.of(context).size.width * 0.1,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(8.0),
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0)),
                                    color:  BUTTON_COLOR),
                                child: Text(
                                  provider.chef!.followers
                                          .contains(provider.myId)
                                      ? 'Followed'
                                      : 'Follow',
                                  style: const TextStyle(color: Colors.white),
                                  overflow: TextOverflow.fade,
                                ))))
              ],
            ),
          );
        }
      } else {
        Container();
      }
      return Container();
    });
  }

  Widget _tabsRow(BuildContext context, RecipeViewProvider provider) {
    return ChipsChoice<int>.single(
      scrollToSelectedOnChanged: true,
      mainAxisAlignment: MainAxisAlignment.center,
      padding: EdgeInsets.zero,
      value: provider.selectedPage,
      onChanged: (val) => provider.changePage(val),
      choiceItems: C2Choice.listFrom<int, String>(
        source: ['Ingredients', 'Procedure'],
        value: (i, v) => i,
        label: (i, v) => v,
        tooltip: (i, v) => v,
      ),
      choiceStyle: C2ChipStyle.filled(
        color: Colors.white,
        selectedStyle: C2ChipStyle(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1),
          backgroundColor:  BUTTON_COLOR,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _tabsContent(RecipeViewProvider provider) {
    return Text(provider.selectedPage == 0
        ? '${recipe.ingredients.length} items'
        : '${recipe.procedure.length} steps');
  }

  Widget _tabsList(RecipeViewProvider provider) {
    return SliverList.builder(
        itemBuilder: (BuildContext context, int index) {
          return provider.selectedPage == 0
              ? IngredientCard(
                  ingredient: recipe.ingredients[index],
                )
              : ProcedureCard(
                  procedure: recipe.procedure[index],
                );
        },
        itemCount: provider.selectedPage == 0
            ? recipe.ingredients.length
            : recipe.procedure.length);
  }
}

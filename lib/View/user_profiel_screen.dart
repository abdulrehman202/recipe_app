import 'package:async/async.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Provider/user_profile_provider.dart';
import 'package:recipe_app/View/Custom%20Widgets/CustomProgressIndicator.dart';
import 'package:recipe_app/View/Custom%20Widgets/SavedRecipeCard.dart';
import 'package:recipe_app/View/recipe_view_screen.dart';

class UserProfielScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  late BuildContext ctx;
  late AsyncMemoizer _memoizer;
  String uid;
  UserProfielScreen({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    ctx = context;
    _memoizer = AsyncMemoizer();
    return ChangeNotifierProvider(create:  (context) => UserProfileProvider(),
      child: Consumer<UserProfileProvider>(
          builder: (ctx, user, _) => Scaffold(
                floatingActionButton: user.scrollPosition == 0.0
                    ? Container()
                    : FloatingActionButton(
                        onPressed: () => user.scrollController.animateTo(0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease),
                        child: const Icon(
                          Icons.arrow_upward,
                          color: Colors.white,
                        )),
                appBar: _appBar(),
                body: _body(user),
              )),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      leading: Container(),
      title: Center(
          child: Text(
        'Profile',
        style: Theme.of(ctx).textTheme.labelMedium,
      )),
    );
  }

  _body(UserProfileProvider provider) {
    return FutureBuilder(
        key: _scaffoldkey,
        future: _memoizer.runOnce(() async {
          await provider.fetchUser(uid);
        }),
        builder: (_, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.done) {
            if (provider.success) {
              return SafeArea(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ListView(
                    controller: provider.scrollController,
                      children: [
                        _headingRow(provider),
                        Container(
                            margin:
                                const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              provider.user!.name,
                              style: Theme.of(ctx)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(color: Colors.black),
                            )),
                        Container(
                            child: const Text(
                              'Chef',
                            )),
                        _bioRow(provider),
                        _tabsRow(provider),
                        const SizedBox(
                          height: 10,
                        ),
                        _contentList(provider),
                      ]),
                ),
              );
            } else {
              return Center(
                child: Text(provider.msg),
              );
            }
          }
          return Center(
            child: CustomProgressIndicator(
              pColor: Constants.BUTTON_COLOR,
            ),
          );
        });
  }

  Widget _headingRow(UserProfileProvider provider) {
    double size = 80.0;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipOval(
          child: Container(
            color: const Color(0xffD9D9D9),
            height: size,
            width: size,
            child: Image.asset(
              Constants.BASE_IMG_PATH + Constants.MICKEY_MOUSE_DP,
              fit: BoxFit.contain,
            ),
          ),
        ),
        _dataColumn('Recipes', provider.listOfRecipes.length),
        _dataColumn('Followers', provider.user!.followers.length),
        _dataColumn('Following', provider.user!.following.length),
      ],
    );
  }

  Widget _dataColumn(String heading, int value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          children: [
            Text(heading),
            Text(
              value.toString(),
              style: Theme.of(ctx).textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _bioRow(UserProfileProvider provider) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ReadMoreText(
        provider.user!.bio,
        trimMode: TrimMode.Line,
        trimLines: 3,
        colorClickableText: Constants.BUTTON_COLOR,
        trimCollapsedText: 'Show more',
        trimExpandedText: ' Show less',
      ),
    );
  }

  Widget _tabsRow(UserProfileProvider provider) {
    return Center(
      child: ChipsChoice<int>.single(
        scrollToSelectedOnChanged: true,
        mainAxisAlignment: MainAxisAlignment.center,
        padding: EdgeInsets.zero,
        value: provider.selectedPage,
        onChanged: (val) => provider.changePage(val),
        choiceItems: C2Choice.listFrom<int, String>(
          source: ['Recipes', 'Videos', 'Tags'],
          value: (i, v) => i,
          label: (i, v) => v,
          tooltip: (i, v) => v,
        ),
        choiceStyle: C2ChipStyle.filled(
          color: Colors.white,
          selectedStyle: C2ChipStyle(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(ctx).size.width * 0.1),
            backgroundColor: Constants.BUTTON_COLOR,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  Widget _contentList(UserProfileProvider provider) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.builder(
            physics: const ScrollPhysics(),
            itemCount: provider.listOfRecipes.length,
            shrinkWrap: true,
            itemBuilder: (ctx, i) {
              return GestureDetector(
                onTap: ()=>Navigator.push(ctx, MaterialPageRoute(builder: (builder)=>RecipeViewScreen(recipe: provider.listOfRecipes[i]))),
                child: SavedecipeCard(
                  recipe: provider.listOfRecipes[i],
                  showTitle: true,
                ),
              );
            }),
      ],
    );
  }
}

import 'dart:ui';

import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/View/Custom%20Widgets/IngredientCard.dart';
import 'package:recipe_app/View/Custom%20Widgets/SavedRecipeCard.dart';

class RecipeViewScreen extends StatefulWidget {
  int _selectedPage = 0;
   RecipeViewScreen({super.key});

  @override
  State<RecipeViewScreen> createState() => _RecipeViewScreenState();
}

class _RecipeViewScreenState extends State<RecipeViewScreen> with TickerProviderStateMixin{
  
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    _tabController = TabController(vsync: this, length: 2);
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          SavedecipeCard(showTitle: false),
          _titleRow(context),
          _userRow(context),
          _tabsRow(),
          _tabsContent(),
        ],
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      actions: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: PopupMenuButton(
            onSelected: (value) => _doSomething(value),
            itemBuilder: (_) => <PopupMenuItem<String>>[
              PopupMenuItem<String>(
                  value: 'Share', child: _popUpMenuTile('Share', Icons.share)),
              PopupMenuItem<String>(
                  value: 'Rate Recipe',
                  child: _popUpMenuTile('Rate Recipe', Icons.star)),
              PopupMenuItem<String>(
                  value: 'Review',
                  child: _popUpMenuTile('Review', Icons.rate_review)),
              PopupMenuItem<String>(
                  value: 'Unsave',
                  child:
                      _popUpMenuTile('Unsave', Icons.bookmark_border_outlined)),
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

  _doSomething(String value) {
    switch (value) {
      case 'Share':
        _share();
        break;

      case 'Rate Recipe':
        _rateRecipe();
        break;

      case 'Review':
        _review();
        break;

      case 'Unsave':
        _unsave();
        break;
    }
  }

  void _share() {}

  void _rateRecipe() {}

  void _review() {}

  void _unsave() {}

  Widget _titleRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Text(
              'Traditional spare ribs baked ',
              overflow: TextOverflow.clip,
              style: Theme.of(context).textTheme.labelMedium,
            )),
        const Expanded(
            child: Align(
                alignment: Alignment.centerRight, child: Text('(13k reviews)')))
      ],
    );
  }

  Widget _userRow(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            children: [
              ClipOval(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.asset(
                    Constants.BASE_IMG_PATH + Constants.DP_IMAGE,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      'William Johns' * 4,
                      style: Theme.of(context).textTheme.labelMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_sharp,
                        color: Constants.BUTTON_COLOR,
                      ),
                      const Text('Faisalabad, Pakistan')
                    ],
                  )
                ],
              ),
            ],
          ),
          Container(
              margin: const EdgeInsets.only(left: 30),
              child:
                  FilledButton(onPressed: () {}, child: const Text('Follow')))
        ],
      ),
    );
  }
  
  Widget _tabsRow()
  {   
    return ChipsChoice<int>.single(
    value: widget._selectedPage,
    onChanged: (val) => setState(() => widget._selectedPage = val),
    choiceItems: C2Choice.listFrom<int, String>(
      source: ['Ingredients', 'Procedure'],
      value: (i, v) => i,
      label: (i, v) => v,
      tooltip: (i, v) => v,
    ),
    choiceStyle: C2ChipStyle.filled(
      color: Colors.white,
      selectedStyle: C2ChipStyle(
        backgroundColor: Constants.BUTTON_COLOR,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    ),
          );
  }
  
  Widget _tabsContent()
  {
    return Expanded(child: widget._selectedPage ==0? _ingredientsPage():_procedurePage());
  }

  Widget _ingredientsPage()
  {
    return Column(
      children: [
        const SizedBox(
          height: 75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(Icons.fastfood_outlined),
                Text('1 Serve'),
              ],
            ), Text('10 items'),],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: 7,
                  itemBuilder: (ctx, i){
                    return IngredientCard();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _procedurePage()
  {
    return const Text('Procedure');
  }
}

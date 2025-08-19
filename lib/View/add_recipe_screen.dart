import 'dart:ui';

import 'package:chips_choice/chips_choice.dart';
import 'package:dart_either/dart_either.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Model/Ingredient.dart';
import 'package:recipe_app/Model/Procedure.dart';
import 'package:recipe_app/Model/Recipe.dart';
import 'package:recipe_app/View/ChooseCategoryScreen.dart';
import 'package:recipe_app/View/Custom%20Widgets/CustomProgressIndicator.dart';
import 'package:recipe_app/View/Custom%20Widgets/FlexibleButton.dart';
import 'package:recipe_app/View/Custom%20Widgets/IngredientCard.dart';
import 'package:recipe_app/View/Custom%20Widgets/ProcedureCard.dart';
import 'package:recipe_app/Provider/add_recipe_provider.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/View/Custom%20Widgets/CustomTextField.dart';

class AddRecipeScreen extends StatelessWidget {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController ingNameCtrlr = TextEditingController();
  FocusNode ingFocusNode = FocusNode();
  FocusNode procedureFocusNode = FocusNode();
  TextEditingController ingQtyCtrlr = TextEditingController();
  TextEditingController procedureCtrlr = TextEditingController();
  TextEditingController timeController = TextEditingController();
  AddRecipeScreen({super.key});  

  @override
  Widget build(BuildContext context) {
    return 
        ChangeNotifierProvider(create:  (context) => AddRecipeProvider(),
      child: Consumer<AddRecipeProvider>(
          builder: (context, recipe, _) => IgnorePointer(
            ignoring: recipe.loading,
            child: Scaffold(
                  bottomNavigationBar: SafeArea(
                    child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: recipe.loading?CustomProgressIndicator(): FilledButton(
                            onPressed: () async {
                              if (recipe.catIndex == -1) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Please add category')));
                              }else if (textEditingController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Recipe name required')));
                              } else if (recipe.ingredientsList.length < 3) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Please add atleast 3 ingredients')));
                              } else if (recipe.procedureList.length < 3) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Please add atleast 3 procedures')));
                              } else {
                                String uid = await Constants.getUserId();
                                Recipe recipeObj = Recipe(
                                    '0',
                                    textEditingController.text,
                                    int.parse(timeController.text),
                                    recipe.catIndex,
                                    recipe.ingredientsList,
                                    recipe.procedureList,
                                    uid,0,0);
                              Either<String, String> res =  await recipe.addRecipe(recipeObj);
                              res.fold(ifLeft: (s){
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s)));
                              }, ifRight: (s){
                                Navigator.pop(context);
                              });
                              }
                            },
                            child: const Text('Add Recipe'))),
                  ),
                  backgroundColor: Colors.white,
                  body: _body(context, recipe),
                  appBar: _appBar(),
                ),
          )),
    );
  }

  PreferredSizeWidget _appBar()
  {
    return AppBar(title: const Center(child: Text('Add Recipe')),);
  }

  Widget ingredientsField(AddRecipeProvider provider) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 8,
                  child: CustomTextField(
                    focusNode: ingFocusNode,
                    hideLsbel: true,
                    lbl: 'Name',
                    controller: ingNameCtrlr,
                  )),
              const Expanded(flex: 1, child: SizedBox()),
              Expanded(
                  flex: 8,
                  child: CustomTextField(
                    hideLsbel: true,
                    lbl: 'Quantity (g)',
                    controller: ingQtyCtrlr,
                    textInputType: TextInputType.number,
                  )),
              const Expanded(flex: 1, child: SizedBox()),
            ],
          ),
          FlexibleButton(
              func: () {
                Ingredient ingredient = Ingredient(
                    (provider.ingredientsList.length + 1).toString(),
                    ingNameCtrlr.text,
                    int.parse(ingQtyCtrlr.text));
                provider.addIngredient(ingredient);
                ingNameCtrlr.clear();
                ingQtyCtrlr.clear();
                ingFocusNode.requestFocus();
              },
              btnText: 'Add Ingredient'),
        ],
      ),
    );
  }

  Widget procedureField(AddRecipeProvider provider) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      child: Row(
        children: [
          Expanded(
              flex: 4,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 150),
                child: TextFormField(
                  focusNode: procedureFocusNode,
                  controller: procedureCtrlr,
                  scrollPadding: EdgeInsets.zero,
                  minLines: 1,
                  maxLines: 50,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Step #${provider.procedureList.length + 1}'),
                ),
              )),
          Expanded(
              flex: 1,
              child: FlexibleButton(
                func: () {
                  if(procedureCtrlr.text.isNotEmpty)
                  {
                    
                  Procedure p = Procedure(
                      (provider.procedureList.length + 1).toString(),
                      provider.procedureList.length + 1,
                      procedureCtrlr.text);
                  provider.addProcedure(p);
                  procedureCtrlr.clear();
                  procedureFocusNode.requestFocus();
                  }
                },
                btnText: 'Add',
              ))
        ],
      ),
    );
  }

  Widget _body(BuildContext context, AddRecipeProvider recipe) {
    return SafeArea(
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          child: CustomScrollView(
              controller: recipe.scrollController,
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: ListTile(
                    onTap: ()async
                    {
                      int? catIndex = await Navigator.push(context, MaterialPageRoute(builder: (ctx)=>const ChooseCategoryScreen()))??-1;
                      recipe.changeCategory(catIndex);
                    },
                    trailing: const Icon(Icons.arrow_forward_ios),
                    title: Text(recipe.catIndex == -1?'Choose Category':Constants.listCategories[recipe.catIndex],style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
                SliverToBoxAdapter(
                  child: CustomTextField(
                      lbl: '*Recipe Name', controller: textEditingController),
                ),
                SliverToBoxAdapter(
                  child: CustomTextField(
                    lbl: 'Time required (in minutes)',
                    controller: timeController,
                    textInputType: TextInputType.number,
                  ),
                ),
                SliverAppBar(
                  backgroundColor: Colors.white,
                  leading: Container(),
                  pinned: true,
                  title: _tabsRow(context, recipe),
                ),
                SliverAppBar.large(
                  collapsedHeight:150,
                  backgroundColor: Colors.white,
                  leading: Container(),
                  pinned: true,
                  flexibleSpace: recipe.selectedPage == 0
                      ? ingredientsField(recipe)
                      : procedureField(recipe),
                ),
                _tabsList(recipe),
              ])),
    );
  }

  Widget _tabsRow(BuildContext context, AddRecipeProvider provider) {
    return ChipsChoice<int>.single(
      scrollToSelectedOnChanged: true,
      mainAxisAlignment: MainAxisAlignment.center,
      padding: EdgeInsets.zero,
      value: provider.selectedPage,
      onChanged: (val) => provider.switchPage(val),
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
          backgroundColor: Constants.BUTTON_COLOR,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }


  Widget _tabsList(AddRecipeProvider provider) {
    return SliverList.builder(
      itemBuilder: (BuildContext context, int index) {
        return provider.selectedPage == 0
            ? IngredientCard(ingredient: provider.ingredientsList[index])
            : ProcedureCard(
                procedure: provider.procedureList[index],
              );
      },
      itemCount: provider.selectedPage == 0
          ? provider.ingredientsList.length
          : provider.procedureList.length,
    );
  }
}
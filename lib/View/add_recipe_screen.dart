import 'dart:ui';

import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Model/Ingredient.dart';
import 'package:recipe_app/Model/Procedure.dart';
import 'package:recipe_app/View/Custom%20Widgets/IngredientCard.dart';
import 'package:recipe_app/View/Custom%20Widgets/ProcedureCard.dart';
import 'package:recipe_app/Provider/add_recipe_provider.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/View/Custom%20Widgets/CustomTextField.dart';

class AddRecipeScreen extends StatelessWidget {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController ingNameCtrlr = TextEditingController();
  TextEditingController ingQtyCtrlr = TextEditingController();
  TextEditingController procedureCtrlr = TextEditingController();
  AddRecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<AddRecipeProvider>(builder: (context, recipe,_) => _body(context, recipe)),
    );
  }

  Widget addWidget(AddRecipeProvider provider)
  {
    return provider.selectedPage == 0?ingredientsField(provider):procedureField(provider);
  }

  Widget ingredientsField(AddRecipeProvider provider)
  {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 7,
                child: CustomTextField(lbl: 'Name',controller: ingNameCtrlr,)),
              const Expanded(
                flex: 1,
                child: SizedBox()),
              Expanded(
                flex: 7,
                child: CustomTextField(lbl: 'Quantity (Grams)', controller: ingQtyCtrlr,textInputType: TextInputType.number,)),
            ],
          ),
          FilledButton(onPressed: ()
          {
            Ingredient ingredient = Ingredient('0', ingNameCtrlr.text, int.parse(ingQtyCtrlr.text));
            provider.addIngredient(ingredient);
            ingNameCtrlr.clear();
            ingQtyCtrlr.clear();
          }, child: const Text('Add Ingredient'))
        ],
      ), 
    );
  }

  Widget procedureField(AddRecipeProvider provider)
  {
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
                constraints: const BoxConstraints(
        maxHeight: 150
      ),
                child: TextFormField(
                  controller: procedureCtrlr,
                  scrollPadding: EdgeInsets.zero,
                  minLines: 1,
                  maxLines: 50,
                  decoration:  InputDecoration(
                      border: InputBorder.none, hintText: 'Step #${provider.procedureList.length+1}'),
                ),
              )),
          Expanded(
              flex: 1,
              child: FilledButton(
                onPressed: (){
                  Procedure p = Procedure('id', provider.procedureList.length+1, procedureCtrlr.text);
                  provider.addProcedure(p);
                  procedureCtrlr.clear();
                },
                child: const Text(
                  'Add',
                  style: TextStyle(color: Colors.white),
                ),
              ))
        ],
      ),
    );
  }

  Widget _body(BuildContext context, AddRecipeProvider recipe) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal:  10.0),
        child:
            CustomScrollView(controller: recipe.scrollController, slivers: <Widget>[
          SliverToBoxAdapter(
            child: CustomTextField(
              lbl: '*Recipe Name',
              controller: textEditingController
            ),
          ),
          SliverAppBar(
            backgroundColor: Colors.white,
            leading: Container(),
            pinned: true,
            title: _tabsRow(context,recipe),
          ),
          SliverAppBar.large(
            backgroundColor: Colors.white,
            leading: Container(),
            pinned: true,
            flexibleSpace: addWidget(recipe),
          ),
          
          _tabsList(recipe),
        ]));
  }

  Widget _tabsRow(BuildContext context, AddRecipeProvider provider) {
    return ChipsChoice<int>.single(
      scrollToSelectedOnChanged: true,
      mainAxisAlignment: MainAxisAlignment.center,
      padding: EdgeInsets.zero,
      value: provider.selectedPage,
      onChanged: (val) => provider.switchPage(val) ,
      choiceItems: C2Choice.listFrom<int, String>(
        source: ['Ingredients', 'Procedure'],
        value: (i, v) => i,
        label: (i, v) => v,
        tooltip: (i, v) => v,
      ),
      choiceStyle: C2ChipStyle.filled(
        color: Colors.white,
        selectedStyle: C2ChipStyle(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1),
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
              return provider.selectedPage == 0?  IngredientCard(ingredient:  provider.ingredientsList[index]):ProcedureCard(procedure: provider.procedureList[index],);
            },
            itemCount: provider.selectedPage ==0? provider.ingredientsList.length: provider.procedureList.length,
          );
  }
}

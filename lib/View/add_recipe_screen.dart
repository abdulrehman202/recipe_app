import 'package:recipe_app/View/all_libs.dart';

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
                                mySnackBar(context, CATEGORY_REQUIRED);
                              }else if (textEditingController.text.isEmpty) {
                                mySnackBar(context, RECIPE_NAME_REQUIRED);
                              } else if (recipe.ingredientsList.length < 3) {
                                mySnackBar(context, ATLEAST_3_INGREDIENTS);
                              } else if (recipe.procedureList.length < 3) {
                                mySnackBar(context, ATLEAST_3_PROCEDURE);
                              } else {
                                String uid = await  getUserId();
                                Recipe recipeObj = Recipe(
                                    '0',
                                    textEditingController.text,
                                    int.parse(timeController.text),
                                    recipe.catIndex,
                                    recipe.ingredientsList,
                                    recipe.procedureList,
                                    uid,0,[]);
                              Either<String, String> res =  await recipe.addRecipe(recipeObj);
                              res.fold(ifLeft: (s){
                                mySnackBar(context, s);
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
                    title: Text(recipe.catIndex == -1?'Choose Category': listCategories[recipe.catIndex],style: const TextStyle(fontWeight: FontWeight.bold),),
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
          backgroundColor:  BUTTON_COLOR,
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
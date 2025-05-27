import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/View/Custom%20Widgets/FilterSheet.dart';
import 'package:recipe_app/View/Custom%20Widgets/SearchField.dart';
import 'package:recipe_app/View/Custom%20Widgets/SearchResultDishCard.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Search Recipe', style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.black, fontSize: 18) ,)),
      ),
      body: _body(),
    );
  }
  
  Widget _body()
  {
    return Padding(padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        searchRow(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text('Recent Search', style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.black, fontSize: 20) ,),
            
        ),
        searchResults()
      ],
    ),
    );
  }

  Widget searchRow() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 50,
      child: Row(
        children: [
          Expanded(child: SearchField()),
          GestureDetector(
              child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Constants.BUTTON_COLOR,
                      borderRadius: BorderRadius.circular(10)),
                  child: GestureDetector(
                    onTap: () => showModalBottomSheet(context: context, builder: (context)=>FilterSheet()),
                    child: ImageIcon(
                      AssetImage(
                        Constants.BASE_IMG_PATH + Constants.FILTER_ICON,
                      ),
                      color: Colors.white,
                    ),
                  )))
        ],
      ),
    );
  }
  
  Widget searchResults() 
  {
    double margin = 5.0;
    return 
    Flexible(
      child: GridView.builder(
        
        shrinkWrap: true,
        itemCount: 8,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2),
        
        itemBuilder: (c, i)
        {
          return Container(
            margin: i%2==0? EdgeInsets.only(bottom: margin, right: margin):EdgeInsets.only(bottom: margin, left: margin),
            child: const SearchResultDishCard());
        }),
    );
  }
}
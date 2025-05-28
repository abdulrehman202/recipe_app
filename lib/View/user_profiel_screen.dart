import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/View/Custom%20Widgets/SavedRecipeCard.dart';

class UserProfielScreen extends StatefulWidget {
  const UserProfielScreen({super.key});

  @override
  State<UserProfielScreen> createState() => _UserProfielScreenState();
}

class _UserProfielScreenState extends State<UserProfielScreen> {
  int _selectedPage = 0;
  ScrollController _scrollController = ScrollController();

  double _scrollPosition=0.0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       floatingActionButton: _scrollPosition==0.0?Container(): FloatingActionButton(
          onPressed: () => _scrollController.animateTo(0,
              duration: const Duration(milliseconds: 500), curve: Curves.ease),
          child: const Icon(Icons.arrow_upward,color: Colors.white,)),
      appBar: _appBar(),
      body: _body(),
    );
  }
  
  PreferredSizeWidget _appBar()
  {
    return AppBar(
      leading: Container(),
      title: Center(child: Text('Profile', style: Theme.of(context).textTheme.labelMedium,)),
    );
  }
  
  _body()
  {
    return SafeArea(child: 
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headingRow(),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child:  Text('Afuwape Abiodun', style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.black),)),
            Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            child:  const Text('Chef',)),
        
            _bioRow(),
            _tabsRow(),
            const SizedBox(height: 10,),
            _contentList(),
        ]),
      ),
    ),
    
    );
  }
  
  Widget _headingRow()
  {
    double size = 80.0;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
          ClipOval(
            child: Container(
              color: const Color(0xffD9D9D9),
              height: size,
              width: size,
              child: Image.asset(Constants.BASE_IMG_PATH+Constants.MICKEY_MOUSE_DP, fit: BoxFit.contain,),
            ),
          ),
        _dataColumn('Recipes', 4),
        _dataColumn('Followers', 10),
        _dataColumn('Following', 7),
      ],
    );
  }

  Widget _dataColumn(String heading, int value)
  {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          children: [
            Text(heading),
            Text(value.toString(),style: Theme.of(context).textTheme.labelMedium,),
          ],
        ),
      ),
    );
  }
  
  Widget _bioRow()
  {
    return Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: ReadMoreText(
              'Private ChefPassionate about food and life'*10,
              trimMode: TrimMode.Line,
              trimLines: 3,
              colorClickableText: Constants.BUTTON_COLOR,
              trimCollapsedText: 'Show more',
              trimExpandedText: ' Show less',
            ),
          );
  }
  
  Widget _tabsRow()
  {
    return Center(
      child: ChipsChoice<int>.single(
        scrollToSelectedOnChanged: true,
        mainAxisAlignment: MainAxisAlignment.center,
        padding: EdgeInsets.zero,
        value: _selectedPage,
        onChanged: (val) => setState(() {
          _selectedPage = val;
        }),
        choiceItems: C2Choice.listFrom<int, String>(
          source: ['Recipes', 'Videos', 'Tags'],
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
      ),
    );
  }
  
  Widget _contentList()
  {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.builder(
          physics: const ScrollPhysics(),
          itemCount: 6,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return SavedecipeCard(showTitle: true, );
          }
        ),
      ],
    );
  }
}
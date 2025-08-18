import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Model/Review.dart';
import 'package:recipe_app/Provider/review_screen_provider.dart';
import 'package:recipe_app/View/Custom%20Widgets/CommentCard.dart';
import 'package:recipe_app/View/Custom%20Widgets/CustomProgressIndicator.dart';


class ReviewScreen extends StatefulWidget {
  String recipeId;
  ReviewScreen({super.key, required this.recipeId,});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  AsyncMemoizer _memoizer = AsyncMemoizer();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _scrollController = ScrollController();
  TextEditingController _commentController = TextEditingController();

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
    return ChangeNotifierProvider(
      create:  (context) => ReviewProvider(),
      
      child: ChangeNotifierProvider(
      create:  (context) => ReviewProvider(),
      child: Consumer<ReviewProvider>(
          builder: (context, reviewProvider, _)=> IgnorePointer(
            ignoring: reviewProvider.loading,
            child: Scaffold(
              key: _scaffoldKey,
                    floatingActionButton: _scrollPosition<=500.0?Container(): FloatingActionButton(
              onPressed: () => _scrollController.animateTo(0,
                  duration: const Duration(milliseconds: 500), curve: Curves.ease),
              child: const Icon(Icons.arrow_upward,color: Colors.white,)),
                    appBar: _appBar(),
                    body: FutureBuilder(
                      future: _memoizer.runOnce(()async{await reviewProvider.getReviews(widget.recipeId);}),
                      builder: (context, asyncSnapshot) {
                        if(asyncSnapshot.connectionState == ConnectionState.waiting)
                        {
                          return CustomProgressIndicator(pColor: Constants.BUTTON_COLOR,);
                        }
                        return _body(reviewProvider);
                      }
                    ),
                  ),
          ),
      ),
    ) 
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: Center(
          child: Text(
        'Reviews',
        style: Theme.of(context).textTheme.labelMedium,
      )),
    );
  }

  Widget _infoRow(int reviewsCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$reviewsCount Reviews'),
        const Text('225 Saved'),
      ],
    );
  }

  Widget _body(ReviewProvider  provider) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        controller: _scrollController,
        children: [
          _infoRow(provider.reviewsList.length),
          Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: Text(
                'Leave a Comment',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(fontSize: 16),
              )),
          _writeReview(provider),
          _commentsList(provider.reviewsList),
        ],
      ),
    ));
  }

  Widget _writeReview(ReviewProvider provider ) {
    return Container(

      
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      child: Row(
        children: [
          Expanded(
              flex: 8,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
        maxHeight: 150
      ),
                child: TextFormField(
                  controller: _commentController,
                  scrollPadding: EdgeInsets.zero,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(fontSize: 16),
                  minLines: 1,
                  maxLines: 50,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: 'Write a review...'),
                ),
              )),
          Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () async
                {
                  if(_commentController.text.isEmpty)
                  {
                    ScaffoldMessenger.of(_scaffoldKey.currentState!.context).showSnackBar(const SnackBar(content: Text('Comment cannot be empty')));
                  }
                  else{
                    String myName = await provider.getMyName();
                    Review review = Review('0', widget.recipeId, myName, DateTime.now(), _commentController.text , [], []);
                    await provider.addReview(review);
                    if(provider.success)
                    {
                      _commentController.clear();
                    }

                  }
                },
                child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 10.0),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        color: Constants.BUTTON_COLOR),
                    child: provider.loading?CustomProgressIndicator(): Text(
                      'Send',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: Colors.white),
                    )),
              ))
        ],
      ),
    );
  }

  Widget _commentsList(List<Review> reviews) {
    return Column(
      children: [
        ListView.separated(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: reviews.length,
            itemBuilder: (ctx, i) {
              return CommentCard(comment: reviews[i]);
            }, 
            separatorBuilder: (BuildContext context, int index) { return Divider(); },),
      ],
    );
  }
}

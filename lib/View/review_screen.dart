import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/View/Custom%20Widgets/CommentCard.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
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

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: Center(
          child: Text(
        'Reviews',
        style: Theme.of(context).textTheme.labelMedium,
      )),
    );
  }

  Widget _infoRow() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('13k Reviews'),
        Text('225 Saved'),
      ],
    );
  }

  Widget _body() {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoRow(),
            Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: Text(
                  'Leave a Comment',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(fontSize: 16),
                )),
            _writeReview(),
            _commentsList(),
          ],
        ),
      ),
    ));
  }

  Widget _writeReview() {
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
              child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 10),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5.0, vertical: 10.0),
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      color: Constants.BUTTON_COLOR),
                  child: Text(
                    'Send',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Colors.white),
                  )))
        ],
      ),
    );
  }

  Widget _commentsList() {
    return Column(
      children: [
        ListView.builder(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: 100,
            itemBuilder: (ctx, i) {
              return const CommentCard();
            }),
      ],
    );
  }
}

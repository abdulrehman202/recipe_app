import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Model/Review.dart';

class CommentCard extends StatelessWidget {
  Review comment;
  CommentCard({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              ClipOval(
                child: Container(
                  margin: const EdgeInsets.only(right: 10.0),
                  width: 50,
                  height: 50,
                  child: Image.asset(
                    Constants.BASE_IMG_PATH + Constants.DP_IMAGE,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.reviewedByName,
                        style: Theme.of(context).textTheme.labelMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(_getDateTime(comment.time))
                    ],
                  ))
            ],
          ),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                comment.comment,
                overflow: TextOverflow.clip,
              )),
          Row(
            children: [
              _thumbsIcon(context, Icons.thumb_up, comment.likes.length , false),
              _thumbsIcon(context, Icons.thumb_down, comment.dislikes.length , false),
            ],
          )
        ],
      ),
    );
  }

  Widget _thumbsIcon(
      BuildContext context, IconData thumb, int i, bool isSelected) {
    return InkWell(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal:  10.0, vertical: 5.0),
          decoration: isSelected
              ? const BoxDecoration(
                  color: Color(0xffD9D9D9),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)))
              : const BoxDecoration(),
          child: Row(
            children: [
              Icon(
                thumb,
                color: Constants.YELLOW_LABEL_COLOR,
              ),
              Container(
                  margin: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    i.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 16),
                  ))
            ],
          )),
    );
  }

  String _getDateTime(DateTime dt) {
    String day = dt.day.toString();
    String month = Constants.getMonth(dt.month);
    String year = dt.year.toString();
    String time = Constants.get12hrsTime(dt);

    return '$month $day, $year - $time';
  }
}

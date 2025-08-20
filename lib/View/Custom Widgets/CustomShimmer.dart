import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

Widget userInfoShimmer(Widget content)
{
  return Shimmer(
    duration: Duration(milliseconds: 1500), //Default value
    interval: Duration(milliseconds: 5), //Default value: Duration(seconds: 0)
    color: Constants.GREY_LABEL_COLOR, //Default value
    colorOpacity: 0.5, //Default value
    enabled: true, //Default value
    direction: ShimmerDirection.fromLTRB(),  //Default Value
    child: content,
  );
}
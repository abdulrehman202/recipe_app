import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> mySnackBar(BuildContext context, String msg)
{
  return ScaffoldMessenger.of(context).showSnackBar(
                                     SnackBar(
                                        content: Text(
                                            msg)));
}

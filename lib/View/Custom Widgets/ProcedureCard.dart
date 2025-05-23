import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';

class ProcedureCard extends StatelessWidget {
  int stepNumber;
  ProcedureCard({super.key, required this.stepNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Constants.RECIPE_CARD_COLOR,
        borderRadius: const BorderRadius.all(Radius.circular(10.0))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
            child: Text('Step ${stepNumber+1}', style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 14))),
          Text('Lorem Ipsum tempor incididunt ut labore et dolore,in voluptate velit esse cillum dolore eu fugiat nulla pariatur? '*10, overflow: TextOverflow.clip, )
        ],
      ),
    );
  }
}
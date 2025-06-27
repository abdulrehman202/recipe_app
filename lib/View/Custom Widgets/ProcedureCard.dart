import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';
import 'package:recipe_app/Model/Procedure.dart';

class ProcedureCard extends StatelessWidget {
  Procedure procedure;
  ProcedureCard({super.key, required this.procedure,});

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
            child: Text('Step ${procedure.stepNo}', style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 14))),
          Text(procedure.procedure, overflow: TextOverflow.clip, )
        ],
      ),
    );
  }
}
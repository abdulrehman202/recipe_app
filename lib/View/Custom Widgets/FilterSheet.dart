import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';

class FilterSheet extends StatefulWidget {
  int? selectedRating = 0;
  List<int> selectedCategory;
  FilterSheet({super.key, required this.selectedRating, required this.selectedCategory});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  int? _selectedTime = 0,_selectedRating = 0;
  List<int> _selectedCategory = [];
  var chipStyle = C2ChipStyle.outlined(
        color: Constants.BUTTON_COLOR,
        selectedStyle: C2ChipStyle.filled(
          color: Constants.BUTTON_COLOR,
         foregroundColor: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      );
      
      @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedRating = widget.selectedRating;
    _selectedCategory = widget.selectedCategory;
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      color: Colors.white,
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [ 
          Text('Time',style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.black)),
          _timeChoices(),
          Text('Rating',style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.black)),
          _ratingChoices(),
          Text('Category',style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.black)),
          _categoryChoices(),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 20.0, top: 20.0),
            alignment: Alignment.center,
            child: FilledButton(onPressed: (){
              Navigator.pop(context,[
                _selectedRating,
                _selectedCategory
              ]);
            }, child: const Text('Filter'))),
    
        ],
      ),
    );
  }
  
  Widget _timeChoices()
  {
    return ChipsChoice<int>.single(
      wrapped: true,
      value: _selectedTime,
      onChanged: (val) => setState(() => _selectedTime = val),
      choiceItems: C2Choice.listFrom<int, String>(
        source: ['All', 'Newest','Oldest','Popularity'],
        value: (i, v) => i,
        label: (i, v) => v,
        tooltip: (i, v) => v,
      ),
      choiceStyle: chipStyle
    );
  }
  
  Widget _ratingChoices() 
  {
    return ChipsChoice<int>.single(
      wrapped: true,
      value: _selectedRating,
      onChanged: (val) => setState(() => _selectedRating = val),
      choiceItems: C2Choice.listFrom<int, String>(
        
        source: ['≥ 1 \u2605','≥ 2 \u2605','≥ 3 \u2605', '≥ 4 \u2605','5 \u2605'],
        value: (i, v) => i,
        label: (i, v) => v,
        tooltip: (i, v) => v,
      ),
      choiceStyle: chipStyle,
    );
  }
  
  Widget _categoryChoices()
  {
    return ChipsChoice<int>.multiple(
      choiceCheckmark: true,
      wrapped: true,
      value: _selectedCategory,
      onChanged: (val) => setState(() => _selectedCategory = val),
      choiceItems: C2Choice.listFrom<int, String>(
        
        source: Constants.listCategories,
        value: (i, v) => i,
        label: (i, v) => v,
        tooltip: (i, v) => v,
      ),
      choiceStyle: chipStyle,
    );
  }
}
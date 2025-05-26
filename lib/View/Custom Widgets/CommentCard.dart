import 'package:flutter/material.dart';
import 'package:recipe_app/Constants.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ClipOval(
                          child: Container(
                            margin: const EdgeInsets.only(right: 10.0),
                            width: 40,
                            height: 40,
                            child: Image.asset(Constants.BASE_IMG_PATH+ Constants.DP_IMAGE, fit: BoxFit.fill,),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('William John',style: Theme.of(context).textTheme.labelMedium , overflow: TextOverflow.ellipsis ,),
                             Text(_getDateTime(DateTime.now()) )
                          ],
                        ))
                    ],
                  ),
                  
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    child: const Text('Lorem Ipsum tempor incididunt ut labore et dolore,inise voluptate velit esse cillum', overflow: TextOverflow.clip,))
                ,Row(
                  children: [
                    _thumbsIcon(context, Icons.thumb_up, 2,true),
                    _thumbsIcon(context,Icons.thumb_down, 10,false),
                  ],
                )
                ],
              ),
            );
  }
  
  Widget _thumbsIcon(BuildContext context, IconData thumb, int i, bool isSelected) 
  {
    return 
                    Container(
                      
                      padding: const EdgeInsets.all(10.0),
                      decoration: isSelected? const BoxDecoration(
                        color: Color.fromARGB(255, 187, 232, 255),
                        borderRadius: BorderRadius.all(Radius.circular(20.0))
                      ):const BoxDecoration(),
                      child: Row(
                        children: [
                          Icon(thumb, color: Constants.YELLOW_LABEL_COLOR,),
                          Container(
                            margin: const EdgeInsets.only(left: 10.0),
                            child: Text(i.toString(), style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 16),))
                        ],
                      ));
  }
  
  String _getDateTime(DateTime dt)
  {
    String day = dt.day.toString();
    String month = Constants.getMonth(dt.month);
    String year = dt.year.toString();
    String time = Constants.get12hrsTime( DateTime.now());

    return  '$month $day, $year - $time';
  }
} 
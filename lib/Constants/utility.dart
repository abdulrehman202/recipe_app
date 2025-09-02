import 'package:shared_preferences/shared_preferences.dart';

 Future<String> getUserId() async
{
 final SharedPreferences prefs = await SharedPreferences.getInstance();
  String uid =  prefs.getString('uid')??'';
  return uid;
}

 setUserId(String uid) async
{
   final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('uid', uid);
}

 double getNetRating(int r, int t)
{
    return t==0?0:r/t;
}


  extension EmailValidation on String {
  bool isValidEmail() {
    final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegex.hasMatch(this);
  }
}

extension TimeFormat on DateTime {
  String get12hrsTime() {
    DateTime dtime = this;
    String time = '';
    String unit = 'am';
    String min = dtime.minute.toString(), hour = dtime.hour.toString();
    
    if(dtime.hour>12)
    {
      hour = (dtime.hour-12).toString();
      unit = 'pm';
    }

    time = '$hour:${min.padLeft(2,'0')} $unit';
    return time;
  }
}

extension MonthName on int {
  String getMonthName() {
    switch(this)
    {
      case 1:
      return 'January';

      case 2:
      return 'February';

      case 3:
      return 'March';

      case 4:
      return 'April';

      case 5:
      return 'May';

      case 6:
      return 'June';

      case 7:
      return 'July';

      case 8:
      return 'August';

      case 9:
      return 'September';

      case 10:
      return 'October';

      case 11:
      return 'November';

      case 12:
      return 'December';

      default:
      return '';
    }
  }
}
import 'dart:ui';

import 'package:flutter/material.dart';

class Constants{
  static String APP_NAME = 'Recipe App';
  static String FONT_NAME = 'Poppins';
  static String BASE_IMG_PATH = 'assets/images/';
  static String SPLASH_IMAGE = 'splash.png';
  static String CHEF_HAT_ICON = 'chef.png';
  static String ARROW_RIGHT = 'Arrow-Right.png';
  static String FB_ICON = 'facebook.png';
  static String GOOGLE_ICON = 'google.png';
  static String FILTER_ICON = 'filter.png';
  static String BITMOJI_IMAGE = 'bitmoji.png';
  static String DISH_IMAGE = 'dish.png';
  static String DP_IMAGE = 'dp.png';
  static String SEARCH_DISH_IMAGE = 'searchdish.png';
  static String MICKEY_MOUSE_DP = 'download.jpg';
  static String HOME_ICON = 'home.png';
  static String NOTIFICATION_ICON = 'notification.png';
  static String SAVE_ICON = 'save.png';
  static String PROFILE_ICON = 'profile.png';
  static String PROFILE_IMAGE_ICON = 'profile_image.png';


  static Color BUTTON_COLOR = Color(0xff129575);
  static Color YELLOW_LABEL_COLOR = Color(0xffFF9C00);
  static Color GREY_LABEL_COLOR = Color(0xff878787);
  static Color BITMOJI_COLOR = Color(0xffFFCE80);
  static Color RECIPE_CARD_COLOR = Color(0xffD9D9D9);

  static String get12hrsTime(DateTime dtime)
  {
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

  static  getMonth(int num)
  {
    switch(num)
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
static RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  
}
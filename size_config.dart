import 'package:flutter/widgets.dart';

class SizeConfig{
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  static double screenPixels;
  static String strBlockHorizontal;
  static String strBlockVertical;
  void init(BuildContext context){
    _mediaQueryData = MediaQuery.of(context);
    screenPixels = _mediaQueryData.devicePixelRatio;
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }
}
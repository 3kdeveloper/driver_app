import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate width as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}

// Get the percentage width as per screen size
double getPercentageScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  return inputWidth * screenWidth;
}

// Get the percentage height as per screen size
double getPercentageScreenHeight(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  return inputWidth * screenWidth;
}

// A method that returns the adaptive text size according to different screen sizes
double getAdaptiveTextSize(double value) {
  // 812 is the design screen height
  return (value / 812.0) * SizeConfig.screenHeight;
}

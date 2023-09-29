import 'package:awii/core/utils/size_config.dart';

extension SizeConfigExt on num {
  /// Calculates the height depending on the device's screen size
  ///
  /// Eg: 20.h -> will take 20% of the screen's height
  double get h => getProportionateScreenHeight(toDouble());

  /// Calculates the width depending on the device's screen size
  ///
  /// Eg: 20.w -> will take 20% of the screen's width
  double get w => getProportionateScreenWidth(toDouble());

  /// Calculates the sp (Scalable Pixel) depending on the device's screen size
  double get sp => getAdaptiveTextSize(toDouble());
}

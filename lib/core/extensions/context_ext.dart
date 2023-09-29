import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  void unFocusKeyboard() async => FocusScope.of(this).unfocus();

  /// Media Query Values
  double get w => MediaQuery.of(this).size.width;
  double get h => MediaQuery.of(this).size.height;
  double get paddingTop => MediaQuery.of(this).padding.top;
}

import 'package:flutter/material.dart';

class SkOnboardingModel {
  String title;
  String description;
  Color titleColor;
  Color descriptionColor;
  String imagePath;

  SkOnboardingModel({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.titleColor,
    required this.descriptionColor,
  });
}

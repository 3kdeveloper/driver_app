import 'package:flutter/material.dart';
import '../../intro/sk_onboarding_model.dart';
import '../../intro/sk_onboarding_screen.dart';
import '../../styles/styles.dart';
import '../language/languages.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {

  final pages = [
    SkOnboardingModel(
        title: 'Choose your goods',
        description:
        'You have an important commodity, products, parcels, or papers and would like to move them quickly',
        titleColor: Colors.black,
        descripColor: const Color(0xFF929794),
        imagePath: 'assets/images/splash1.jpg'),
    SkOnboardingModel(
        title: 'Select pickup and drop locations',
        description:
        'Open the account easily and choose the place of receipt and delivery and the type of goods or anything you want to transfer',
        titleColor: Colors.black,
        descripColor: const Color(0xFF929794),
        imagePath: 'assets/images/splash2.jpg'),
    SkOnboardingModel(
        title: 'Pay after delivery',
        description: 'awii express will deliver your goods to you in a short time and at cheap prices',
        titleColor: Colors.black,
        descripColor: const Color(0xFF929794),
        imagePath: 'assets/images/splash3.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SKOnboardingScreen(
        bgColor: Colors.white,
        themeColor: buttonColor,
        pages: pages,
        skipClicked: (value) {

        },
        getStartedClicked: (value) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const Languages()));
        },
      ),
    );
  }
}

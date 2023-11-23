import 'package:Asur/Global_Vairables/background_screen.dart';
import 'package:Asur/Navigator/bottom_navigation.dart';
import 'package:Asur/Profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import '../Auth/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<bool> checkFirstTimeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTimeUser = prefs.getBool('isFirstTimeUser') ?? true;
    return isFirstTimeUser;
  }

  Future<bool> LogedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTimeUser = prefs.getBool('LogedIn') ?? false;
    return isFirstTimeUser;
  }

  Future<void> _navigateToNextScreen() async {
    print("Navigating to next screen...");
    await Future.delayed(
        Duration(seconds: 5)); // Display splash screen for 2 seconds
    print("Navigating now!");
    if (await LogedIn()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomNavigation(0)),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          GradientContainer(),
          WidgetAnimator(
              atRestEffect: WidgetRestingEffects.wave(effectStrength: 0.6),
              incomingEffect:
                  WidgetTransitionEffects.incomingOffsetThenScaleAndStep(
                      delay: Duration(milliseconds: 300),
                      duration: Duration(milliseconds: 4000)),
              child: Image.asset(
                'assets/without background logo.png',
                height: height * 0.25,
                width: width * 0.66,
              )),
        ],
      ),
    );
  }
}

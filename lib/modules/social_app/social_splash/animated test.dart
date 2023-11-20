import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/modules/social_app/social_login/social_login_screen.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Image.asset('images/logo.png'),
        splashIconSize: 250,
        duration: 4000,
        splashTransition: SplashTransition.fadeTransition,
        nextScreen: SocialLoginScreen());
  }
}

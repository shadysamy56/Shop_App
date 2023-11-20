import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do_list/layout/social_app/social_layout.dart';
import 'package:to_do_list/shared/components/components.dart';

class SocialSplashScreen extends StatefulWidget {
  const SocialSplashScreen({super.key});

  @override
  State<SocialSplashScreen> createState() => _SocialSplashScreenState();
}

class _SocialSplashScreenState extends State<SocialSplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(seconds: 3), () {
      navigateAndfinish(context, SocialLayout());
    });
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: SafeArea(
          top: false,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.edit,
                  size: 80,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'ConnectRix',
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 32.0,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

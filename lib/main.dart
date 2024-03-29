// ignore_for_file: prefer_const_constructors, unused_import, await_only_futures, use_key_in_widget_constructors, avoid_print, unnecessary_null_comparison

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:to_do_list/layout/news_app/cubit/cubit.dart';
import 'package:to_do_list/layout/news_app/cubit/states.dart';
import 'package:to_do_list/layout/news_app/news_layout.dart';
import 'package:to_do_list/layout/shop_app/cubit/shopcubit.dart';
import 'package:to_do_list/layout/shop_app/shop_layout.dart';
import 'package:to_do_list/layout/social_app/cubit/socialcubit.dart';
import 'package:to_do_list/layout/social_app/social_layout.dart';
import 'package:to_do_list/modules/shop_app/login/login_screen.dart';
import 'package:to_do_list/modules/shop_app/on_boarding/onboarding_screen.dart';
import 'package:to_do_list/modules/social_app/social_call_shortcut/social_call_screen.dart';
import 'package:to_do_list/modules/social_app/social_login/social_login_screen.dart';
import 'package:to_do_list/modules/social_app/social_splash/animated%20test.dart';
import 'package:to_do_list/modules/social_app/social_splash/social_splash_screen.dart';
import 'package:to_do_list/shared/bloc_observer.dart';
import 'package:to_do_list/shared/components/constants.dart';
import 'package:to_do_list/shared/network/local/cache_helper.dart';
import 'package:to_do_list/shared/network/remote/dio_helper.dart';
import 'package:to_do_list/shared/styles/themes.dart';
import 'package:page_transition/page_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getBool(key: 'isDark');

  //bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');

  uId = CacheHelper.getData(key: 'uId');

  Widget? widget;

  if (uId != null) {
    widget = SocialLayout();
  } else {
    widget = SocialLoginScreen();
  }

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startWidget;

  const MyApp({
    this.isDark,
    this.startWidget,
  });

// class MyApp extends StatelessWidget {
//   const MyApp(this.isDark, this.onBoarding);
//   final bool? isDark;
//   final bool? onBoarding;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()..changeAppMode(fromShared: isDark),
        ),
        BlocProvider(
          create: (context) => NewsCubit()..getBusiness(),
        ),
        BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategoriesData()
            ..getFavorites()
            ..getUserData(),
        ),
        BlocProvider(
          create: (context) => SocialCubit()
            ..getUserData()
            ..getPosts(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: AnimatedSplashScreen(
              splash: Image.asset('images/logo.png'),
              splashIconSize: 400,
              duration: 4000,
              splashTransition: SplashTransition.scaleTransition,
              animationDuration: Duration(seconds: 3),
              backgroundColor: Colors.white,
              nextScreen: startWidget!,
              //nextScreen: SocialCallScreen(),
            ),
          );
        },
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, unnecessary_string_interpolations, avoid_print
// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors ,prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:to_do_list/modules/shop_app/login/login_screen.dart';
import 'package:to_do_list/shared/components/components.dart';
import 'package:to_do_list/shared/network/local/cache_helper.dart';
import 'package:to_do_list/shared/styles/colors.dart';

class BoardingModel {
  late final String image;
  late final String title;
  late final String body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();
  bool isLast = false;

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndfinish(context, ShopLoginScreen());
      }
    });
  }

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'images/onboarding_1.jpg',
      title: 'Easy and Quick',
      body: 'Here you will find whatever you like whenever you want',
    ),
    BoardingModel(
      image: 'images/onboarding_2.jpg',
      title: 'World of Choices',
      body: 'All categories of products ',
    ),
    BoardingModel(
      image: 'images/onboarding_3.jpg',
      title: 'Welcome to Shady Shop',
      body: 'We are happy to serve you',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: submit,
            child: Text('SKIP'),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: ((context, index) =>
                    buildBoardingItem(boarding[index])),
                itemCount: boarding.length,
                physics: BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: ((int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                }),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotWidth: 10,
                    dotHeight: 10,
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    spacing: 5,
                    expansionFactor: 3,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage('${model.image}'))),
          SizedBox(
            height: 30.0,
          ),
          Text(
            '${model.title}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            '${model.body}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
        ],
      );
}

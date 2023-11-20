// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:to_do_list/shared/components/components.dart';

class SocialCallScreen extends StatelessWidget {
  const SocialCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Shady Call Example'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                callPhoneNumber(
                  phoneNumber: '01277946410',
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.call,
                    size: 30.0,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Phone',
                    style: TextStyle(fontSize: 30.0),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            TextButton(
              onPressed: () {
                openWhatsAppChat(
                  phoneNumber: '01277946410',
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.chat,
                    size: 30.0,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Whatsapp',
                    style: TextStyle(fontSize: 30.0),
                  ),
                ],
              ),
            ),
          ],
        )));
  }
}

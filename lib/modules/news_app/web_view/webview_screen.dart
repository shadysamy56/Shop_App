// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors_in_immutables, non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_string_interpolations, unused_local_variable

import 'package:flutter/material.dart';

class WebViewScreen extends StatelessWidget {
  late final String url;
  WebViewScreen(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: const Column()

        //WebView(
        // initialUrl: url,
        );
  }
}

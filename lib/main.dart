import 'package:flutter/material.dart';
import 'package:git_client_mobile/utils/color.dart';
import 'package:git_client_mobile/pages/home.dart';

void main() => runApp(GitClientMobile());

class GitClientMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Git Client Mobile',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: whiteGradient,
      ),
      home: MyHomePage(title: 'Git Client Mobile'),
    );
  }
}

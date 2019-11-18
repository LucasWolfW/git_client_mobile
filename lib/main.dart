import 'package:flutter/material.dart';
import 'package:git_client_mobile/utils/color.dart';
import 'package:git_client_mobile/app.dart';
import 'package:git_client_mobile/pages/Login.dart';
import 'package:git_client_mobile/pages/Welcome.dart';

void main() => runApp(GitClientMobile());

class GitClientMobile extends StatelessWidget {
  GitClientMobile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Git Mobile',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _generateRoutes(),
      theme: ThemeData(
        primarySwatch: whiteGradient,
      ),
    );
  }
}

RouteFactory _generateRoutes() {
  return (settings) {
    Widget page;
    switch (settings.name) {
      case '/':
        page = Welcome();
        break;
      case '/home':
        page = MyHomePage();
        break;
      case Login.routeName:
        page = Login();
        break;
      default:
        return null;
    }
    return MaterialPageRoute(builder: (BuildContext context) => page);
  };
}

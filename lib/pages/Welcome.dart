import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<Welcome> {
  @override
  void initState() {
    super.initState();
    auth();
  }

  auth() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('authorization');
    print(token);
    await Future.delayed(Duration(seconds: 1));

    if (token == null) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/login', ModalRoute.withName('/'));
    } else {
      // Navigator.of(context).pushNamedAndRemoveUntil('/login', ModalRoute.withName('/'));
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/home', ModalRoute.withName('/'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
          child: Container(
        width: 150,
        height: 150,
        child: Image.asset("assets/LoginLogo.png"),
      )),
      padding: EdgeInsets.all(0),
    );
  }
}

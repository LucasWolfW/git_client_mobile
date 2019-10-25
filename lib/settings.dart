import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  Settings({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: SettingsGrey,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          ListTile(
              leading: Column(
                children: <Widget>[
                  Icon(Icons.help),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              title: Text('FAQ'),
              subtitle: Text('Answers to Frequently Asked Questions'),
              onTap: () {
                _launchURL("https://help.github.com/");
              }),
          ListTile(
            leading: Column(
              children: <Widget>[
                Icon(Icons.person),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            title: Text("Contact Us"),
            subtitle: Text("Questions? Need help?"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.insert_drive_file),
            title: Text("Terms and Privacy Policy"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("App info"),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

const SettingsGrey = (Color(0xFFFAFAFA));

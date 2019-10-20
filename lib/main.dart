import 'package:flutter/material.dart';

void main() => runApp(GitClientMobile());

class GitClientMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Git Client Mobile',
      theme: ThemeData(
        primarySwatch: primaryDarkGrey,
      ),
      home: MyHomePage(title: 'Git Client Mobile'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
        body: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.polymer),
              title: Text('Projeto GCS'),
            ),
            ListTile(
              leading: Icon(Icons.polymer),
              title: Text('Projeto WEB 1'),
            ),
            ListTile(
              leading: Icon(Icons.polymer),
              title: Text('Projeto Scalar'),
            ),
            ListTile(
              leading: Icon(Icons.polymer),
              title: Text('Projeto Pascal'),
            ),
            ListTile(
              leading: Icon(Icons.polymer),
              title: Text('Projeto C#'),
            ),
            ListTile(
              leading: Icon(Icons.polymer),
              title: Text('Projeto Cobol'),
            ),
          ],
        ),
      drawer: Drawer(
        child: Container(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: ListView(),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/AppBarLogo.png'),
                      fit: BoxFit.fitWidth),
                ),
              ),
              ListTile(
                title: Text('Projects'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          color: primaryDarkGrey,
        ),
      ),
    );
  }
}

const MaterialColor primaryDarkGrey = MaterialColor(
  0xFFffffff,
  <int, Color>{
    50: Color(0xFF333333),
    100: Color(0xFF333333),
    200: Color(0xFF333333),
    300: Color(0xFF333333),
    400: Color(0xFF333333),
    500: Color(0xFF333333),
    600: Color(0xFF333333),
    700: Color(0xFF333333),
    800: Color(0xFF333333),
    900: Color(0xFF333333),
  },
);

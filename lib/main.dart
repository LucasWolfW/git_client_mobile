import 'package:flutter/material.dart';
import 'package:rounded_floating_app_bar/rounded_floating_app_bar.dart';

void main() => runApp(GitClientMobile());

class GitClientMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Git Client Mobile',
      theme: ThemeData(
        primarySwatch: whiteGradient,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isInnerBoxScroll) {
          return [
            RoundedFloatingAppBar(
              floating: true,
              snap: true,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 45),
                    child: Text(
                      "Git Mobile",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.white,
            ),
          ];
        },
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
          color: whiteGradient,
        ),
      ),
    );
  }
}

const MaterialColor whiteGradient = MaterialColor(
  _whiteGradientPrimaryValue,
  <int, Color>{
    50: Color(_whiteGradientPrimaryValue),
    100: Color(0xFFe6e6e6),
    200: Color(0xFFcdcdcd),
    300: Color(0xFFb4b4b4),
    400: Color(0xFF9b9b9b),
    500: Color(0xFF828282),
    600: Color(0xFF696969),
    700: Color(0xFF505050),
    800: Color(0xFF373737),
    900: Color(0xFF141414),
    1000: Color(0xFF000000),
  },
);
const int _whiteGradientPrimaryValue = 0xFFffffff;

import 'package:flutter/material.dart';
import 'package:git_client_mobile/api.dart';
import 'package:git_client_mobile/color.dart';
import 'package:git_client_mobile/item.dart';
import 'package:git_client_mobile/repo.dart';
import 'package:git_client_mobile/search.dart';
import 'package:rounded_floating_app_bar/rounded_floating_app_bar.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Repo> _repos = List();
  bool _isFetching = false;
  String _error;

  @override
  void initState() {
    super.initState();
    loadTrendingRepos();
  }

  void loadTrendingRepos() async {
    setState(
      () {
        _isFetching = true;
        _error = null;
      },
    );

    final repos = await Api.getTrendingRepositories();
    setState(
      () {
        _isFetching = false;
        if (repos != null) {
          this._repos = repos;
        } else {
          _error = 'Error fetching repos';
        }
      },
    );
  }

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
              actions: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.grey[600],
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchList(),
                          ));
                    }),
              ],
            ),
          ];
        },
        body: buildBody(context),
      ),
      drawer: Drawer(
        child: Container(
          child: ListView(
            padding: EdgeInsets.all(0),
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/AppBarLogo.png'),
                        fit: BoxFit.fitWidth)),
                accountEmail: Text("git.test@gmail.com",
                    style: TextStyle(color: Colors.grey[100], fontSize: 15)),
                accountName: Text("Git Test",
                    style: TextStyle(color: Colors.grey[100], fontSize: 15)),
                currentAccountPicture: CircleAvatar(
                  child: Text("GT", style: TextStyle(fontSize: 25)),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.search),
                title: Text("Search"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchList(),
                      ));
                },
              ),
              ListTile(
                leading: Icon(Icons.dashboard),
                title: Text("Projects"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text("About Us"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text("Share with Friends"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.rate_review),
                title: Text("Rate and Review"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.flag),
                title: Text("Privacy Policy"),
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

  Widget buildBody(BuildContext context) {
    if (_isFetching) {
      return Container(
          alignment: Alignment.center, child: Icon(Icons.timelapse));
    } else if (_error != null) {
      return Container(
        alignment: Alignment.center,
        child: Text(
          _error,
          style: Theme.of(context).textTheme.headline,
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        itemCount: _repos.length,
        itemBuilder: (BuildContext context, int index) {
          return GithubItem(_repos[index]);
        },
      );
    }
  }
}

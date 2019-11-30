import 'package:flutter/material.dart';
import 'package:git_client_mobile/api/api.dart';
import 'package:git_client_mobile/pages/Profile.dart';
import 'package:git_client_mobile/utils/item.dart';
import 'package:git_client_mobile/api/repo.dart';
import 'package:git_client_mobile/pages/search.dart';
import 'package:git_client_mobile/pages/settings.dart';
import 'package:git_client_mobile/pages/projects.dart';
import 'package:git_client_mobile/api/users.dart';
import 'package:rounded_floating_app_bar/rounded_floating_app_bar.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with AutomaticKeepAliveClientMixin {
  Map<String, dynamic> userData = {};
  UserModel userModel;
  List<Repo> _repos = List();
  bool _isFetching = false;
  String _error;

  @override
  bool get wantKeepAlive => true;

  _fetchUsers() async {
    userModel = UserModel.fromJson(await fetchUsers());
    setState(() {
      userData = userModel.toJson();
    });
  }

  @override
  void initState() {
    super.initState();
    loadTrendingRepos();
    _fetchUsers();
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
    super.build(context);

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
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/AppBarLogo.png'),
                        fit: BoxFit.fitWidth)),
                accountEmail: Text(userData['email'] ?? 'Email not provided',
                    style: TextStyle(color: Colors.grey[100], fontSize: 15)),
                accountName: Text(
                    userData['username'] ?? 'User name not provided',
                    style: TextStyle(color: Colors.grey[100], fontSize: 15)),
                currentAccountPicture: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(
                    userData['avatarUrl'] ?? 'Avatar not provided',
                  ),
                  backgroundColor: Colors.transparent,
                )),
            Container(
              child: InkResponse(
                child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 0,
                  ),
                ),
                highlightShape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5),
                containedInkWell: true,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              margin: EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 2,
              ),
            ),
            Container(
              child: InkResponse(
                child: ListTile(
                  leading: Icon(Icons.search),
                  title: Text('Search'),
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 0,
                  ),
                ),
                highlightShape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5),
                containedInkWell: true,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchList(),
                      ));
                },
              ),
              margin: EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 2,
              ),
            ),
            Container(
              child: InkResponse(
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile'),
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 0,
                  ),
                ),
                highlightShape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5),
                containedInkWell: true,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(),
                      ));
                },
              ),
              margin: EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 2,
              ),
            ),
            Container(
              child: InkResponse(
                child: ListTile(
                  leading: Icon(Icons.dashboard),
                  title: Text('Projects'),
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 0,
                  ),
                ),
                highlightShape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5),
                containedInkWell: true,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Projects(),
                      ));
                },
              ),
              margin: EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 2,
              ),
            ),
            Divider(),
            Container(
              child: InkResponse(
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 0,
                  ),
                ),
                highlightShape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5),
                containedInkWell: true,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Settings(),
                      ));
                },
              ),
              margin: EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    if (_isFetching) {
      return Center(
        child: Container(
          width: 25.0,
          height: 25.0,
          child: CircularProgressIndicator(),
        ),
      );
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

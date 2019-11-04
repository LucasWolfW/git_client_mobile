import 'package:flutter/material.dart';
import 'package:git_client_mobile/api/api.dart';
import 'package:git_client_mobile/utils/item.dart';
import 'package:git_client_mobile/api/repo.dart';
import 'package:git_client_mobile/pages/search.dart';
import 'package:rounded_floating_app_bar/rounded_floating_app_bar.dart';

class Projects extends StatefulWidget {
  Projects({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ProjectsState createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  List<Repo> _repos = List();
  bool _isFetching = false;
  String _error;

  @override
  void initState() {
    super.initState();
    loadUserRepos();
  }

  void loadUserRepos() async {
    setState(
      () {
        _isFetching = true;
        _error = null;
      },
    );

    final repos = await Api.getUserRepositories();
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
    final title = 'Teste';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.map),
              title: Text('Map'),
            ),
            ListTile(
              leading: Icon(Icons.photo_album),
              title: Text('Album'),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Phone'),
            ),
          ],
        ),
      ),
    );
    /*return Scaffold(
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
      )
    );*/
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

const SettingsGrey = (Color(0xFFFAFAFA));

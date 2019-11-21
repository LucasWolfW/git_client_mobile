import 'package:flutter/material.dart';
import 'package:git_client_mobile/utils/AvatarIcon.dart';
import 'package:git_client_mobile/api/users.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic> userData = {};
  UserModel userModel;
  List _list = [];

  _fetchUsers() async {
    userModel = UserModel.fromJson(await fetchUsers());
    setState(() {
      userData = userModel.toJson();
      _list = [
        {'value': userData['followers'], 'text': 'followers'},
        {'value': userData['following'], 'text': 'following'},
        {'value': userData['publicRepos'], 'text': 'repos'},
        {'value': userData['publicGists'], 'text': 'gists'},
      ];
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

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
            'Profile',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          elevation: 0,
        ),
        body: Align(
          alignment: Alignment.topLeft,
          child: Container(
            height: 280.0,
            child: Card(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 15.0),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 5.0),
                      AvatarIcon(
                        width: 80.0,
                        height: 80.0,
                        avatarUrl:
                            userData['avatarUrl'] ?? 'Avatar not provided',
                        userName:
                            userData['username'] ?? 'User name not provided',
                      ),
                      SizedBox(width: 15.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            userData['username'] ?? 'User name not provided',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          Text(userData['location'] ?? 'Location not provided'),
                          _createdAt(userData['createdAt'] ??
                              'Created at not provided'),
                        ],
                      ),
                    ],
                  ),
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text(userData['email'] ?? 'Email not provided'),
                  ),
                  ListTile(
                    leading: Icon(Icons.link),
                    title: _blog(userData['blog'] ?? 'Blog not provided'),
                  ),
                  RowTileList(_list),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _blog(String blog) {
    if (blog == "none") {
      return Text("Blog not provided");
    } else if (blog == "") {
      return Text("Blog not provided");
    } else {
      return Text(userData['blog'] ?? 'Blog not provided');
    }
  }

  Widget _createdAt(String createdAt) {
    if (createdAt == "none") {
      return Text("Blog not provided");
    } else if (createdAt == "") {
      return Text("Blog not provided");
    } else if (createdAt == null) {
      return Text("Blog not provided");
    } else {
      if (createdAt.contains("T")){}
      createdAt = createdAt.replaceAll('T', ' ').replaceAll('Z', '');
      return Text(
          createdAt ??
              "Created at not provided");
    }
  }
}

class RowTileList extends StatelessWidget {
  RowTileList(this.list);

  final _style = TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.w500,
  );

  final List list;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: list.map((item) {
        return Column(
          children: <Widget>[
            Text('${item['value']}', style: _style),
            Text(item['text']),
          ],
        );
      }).toList(),
    );
  }
}

const SettingsGrey = (Color(0xFFFAFAFA));

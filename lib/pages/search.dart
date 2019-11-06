import 'dart:async';

import 'package:flutter/material.dart';
import 'package:git_client_mobile/api/api.dart';
import 'package:git_client_mobile/utils/item.dart';
import 'package:git_client_mobile/api/repo.dart';
import 'package:rounded_floating_app_bar/rounded_floating_app_bar.dart';

class SearchList extends StatefulWidget {
  SearchList({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchState();
}

class _SearchState extends State<SearchList> {
  final key = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();
  bool _isSearching = false;
  String _error;
  List<Repo> _results = List();

  Timer debounceTimer;

  _SearchState() {
    _searchQuery.addListener(() {
      if (debounceTimer != null) {
        debounceTimer.cancel();
      }
      debounceTimer = Timer(Duration(milliseconds: 500), () {
        if (this.mounted) {
          performSearch(_searchQuery.text);
        }
      });
    });
  }

  void performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _error = null;
        _results = List();
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _error = null;
      _results = List();
    });

    final repos = await Api.getRepositoriesWithSearchQuery(query);
    if (this._searchQuery.text == query && this.mounted) {
      setState(() {
        _isSearching = false;
        if (repos != null) {
          _results = repos;
        } else {
          _error = 'Error searching repositories';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      body: NestedScrollView(
        headerSliverBuilder: (context, isInnerBoxScroll) {
          return [
            RoundedFloatingAppBar(
              floating: true,
              snap: true,
              title: TextField(
                autofocus: true,
                controller: _searchQuery,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Padding(
                        padding: EdgeInsetsDirectional.only(end: 5.0),
                        child: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.grey[600],
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            })),
                    hintText: "Search repositories...",
                    hintStyle: TextStyle(color: Colors.black, fontSize: 18)),
              ),
              backgroundColor: Colors.white,
            ),
          ];
        },
        body: buildBody(context),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    if (_isSearching) {
      return Center(
        child: Container(
          width: 25.0,
          height: 25.0,
          child: CircularProgressIndicator(),
        ),
      );
    } else if (_error != null) {
      return CenterTitle(_error);
    } else {
      return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          itemCount: _results.length,
          itemBuilder: (BuildContext context, int index) {
            return GithubItem(_results[index]);
          });
    }
  }
}

class CenterTitle extends StatelessWidget {
  final String title;

  CenterTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        alignment: Alignment.center,
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline,
          textAlign: TextAlign.center,
        ));
  }
}

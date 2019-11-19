import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AvatarIcon extends StatelessWidget {
  AvatarIcon({
    @required this.avatarUrl,
    @required this.userName,
    this.width = 40.0,
    this.height = 40.0,
    this.defaultAvatarUrl = 'assets/images/avatar.png',
    this.defaultUserUrl = 'https://github.com/',
  });

  final String avatarUrl;
  final String userName;
  final String defaultAvatarUrl;
  final double width;
  final double height;
  final String defaultUserUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ClipOval(
        child: FadeInImage.assetNetwork(
            width: width,
            height: height,
            placeholder: '$defaultAvatarUrl',
            image: '$avatarUrl'),
      ),
      onTap: () {
        _launchURL(defaultUserUrl+userName);
      },
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

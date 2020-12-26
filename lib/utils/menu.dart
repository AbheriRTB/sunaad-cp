import 'package:flutter/material.dart';
import 'package:sunaad/pages/info/about.dart';
import 'package:sunaad/pages/info/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.more_vert),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.mail),
            title: Text('Feedback'),
            onTap: () {
              _launchURL();
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.format_paint),
            title: Text('Themes'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.group),
            title: Text('About Us'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
          ),
        ),
      ],
    );
  }

  _launchURL() async {
    String url =
        'mailto:theteamabheri@gmail.com?subject=Sunaad App v1.0.0 feedback&body=';
    if (url.isNotEmpty) {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } else {
      print('NoData');
    }
  }
}

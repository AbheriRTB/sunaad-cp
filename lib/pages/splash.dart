import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sunaad/data/jason_data.dart';
import 'package:sunaad/pages/banner.dart';
import 'package:http/http.dart' as http;

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    void splash() async {
      await (JasonData().fetchPrograms(http.Client()));
      await (JasonData().fetchArtisteDir(http.Client()));
      await (JasonData().fetchVenueDir(http.Client()));
      await (JasonData().fetchOrganizerDir(http.Client()));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BannerPage()));
    }

    splash();
    return Container(
      color: Theme.of(context).primaryColor,
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle.light,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.music_note,
                size: 64,
                color: Theme.of(context).primaryColorLight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sunaad/utils/drawer.dart';
import 'package:sunaad/utils/menu.dart';

class DictionaryVenuePage extends StatefulWidget {
  @override
  _DictionaryVenuePageState createState() => _DictionaryVenuePageState();
}

class _DictionaryVenuePageState extends State<DictionaryVenuePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Venue",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          MenuPopup(),
        ],
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: MyDrawer(
        pos: 8,
      ),
      body: Container(
        child: Center(child: Text("Venue")),
      ),
    );
  }
}

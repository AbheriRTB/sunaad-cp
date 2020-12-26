import 'package:flutter/material.dart';
import 'package:sunaad/utils/drawer.dart';
import 'package:sunaad/utils/list_tile.dart';
import 'package:sunaad/utils/menu.dart';

class DictionaryArtistePage extends StatefulWidget {
  @override
  _DictionaryArtistePageState createState() => _DictionaryArtistePageState();
}

class _DictionaryArtistePageState extends State<DictionaryArtistePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Artists",
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
        pos: 7,
      ),
      body: Container(
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return DirList();
            }),
      ),
    );
  }
}

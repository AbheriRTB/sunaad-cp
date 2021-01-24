import 'package:flutter/material.dart';
import 'package:sunaad/data/jason_data.dart';
import 'package:sunaad/models/artiste.dart';
import 'package:sunaad/utils/drawer.dart';
import 'package:sunaad/utils/list_tile.dart';
import 'package:sunaad/utils/menu.dart';

class DirectoryArtistePage extends StatefulWidget {
  @override
  _DirectoryArtistePageState createState() => _DirectoryArtistePageState();
}

class _DirectoryArtistePageState extends State<DirectoryArtistePage> {
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
        child: FutureBuilder<List<Artiste>>(
          future: JasonData().parseArtisteFromSPData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ArtisteDirList(
                    artiste: snapshot.data[index],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

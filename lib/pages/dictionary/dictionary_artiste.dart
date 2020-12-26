import 'package:flutter/material.dart';
import 'package:sunaad/data/jason_data.dart';
import 'package:sunaad/models/artiste.dart';
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
      body: Container(child: Center(child: Text('Comming Soon'))
          /*
        child: FutureBuilder<List<Artiste>>(
          future: JasonData().parseArtisteFromSPData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return DirList(
                    artiste: snapshot.data[index],
                  );
                },
              );
            }
          },
        ),*/
          ),
    );
  }
}

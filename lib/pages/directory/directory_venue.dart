import 'package:flutter/material.dart';
import 'package:sunaad/data/jason_data.dart';
import 'package:sunaad/models/venue.dart';
import 'package:sunaad/utils/drawer.dart';
import 'package:sunaad/utils/list_tile.dart';
import 'package:sunaad/utils/menu.dart';

class DirectoryVenuePage extends StatefulWidget {
  @override
  _DirectoryVenuePageState createState() => _DirectoryVenuePageState();
}

class _DirectoryVenuePageState extends State<DirectoryVenuePage> {
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
        child: FutureBuilder<List<Venue>>(
          future: JasonData().parseVenueFromSPData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return VenueDirList(
                    venue: snapshot.data[index],
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

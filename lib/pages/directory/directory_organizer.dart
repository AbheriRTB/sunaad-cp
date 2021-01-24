import 'package:flutter/material.dart';
import 'package:sunaad/utils/drawer.dart';
import 'package:sunaad/utils/menu.dart';

class DirectoryOrganizerPage extends StatefulWidget {
  @override
  _DirectoryOrganizerPageState createState() => _DirectoryOrganizerPageState();
}

class _DirectoryOrganizerPageState extends State<DirectoryOrganizerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Organizer",
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
        pos: 9,
      ),
      body: Container(
        child: Center(child: Text("Comming Soon")),
      ),
    );
  }
}

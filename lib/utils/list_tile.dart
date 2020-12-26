import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sunaad/data/urls.dart';
import 'package:sunaad/models/artiste.dart';
import 'package:sunaad/models/programs.dart';
import 'package:flutter/material.dart';
import 'package:sunaad/models/programs.dart';
import 'package:dart_date/dart_date.dart';
import 'package:sunaad/utils/artiste_info.dart';
import 'prog_info.dart';

class DefaultList extends StatelessWidget {
  Programs progs;
  String imageUrl = Urls().image();
  String defaultUrl = Urls().defaultArtisteImage();
  bool isFinished = false, isToday = false;
  int i;

  DefaultList({
    @required this.progs,
  });

  @override
  Widget build(BuildContext context) {
    isFinished = false;
    isToday = false;
    if (progs.event_date.isBefore(DateTime.now())) {
      isFinished = true;
      isToday = false;
    }
    if (progs.event_date.isSameDay(DateTime.now())) {
      isFinished = true;
      isToday = true;
    }

    if (progs.artiste_image.isNotEmpty) {
      defaultUrl = imageUrl + progs.artiste_image;
    } else {
      defaultUrl = Urls().defaultArtisteImage();
    }

    var formatter = DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(progs.event_date);

    TextStyle textStyle(double size) => TextStyle(
        fontSize: size,
        color: isToday ? Colors.orange[600] : Colors.grey[600],
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic);

    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              color: isFinished ? Colors.purple[50] : Colors.transparent,
              child: InkWell(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        minRadius: 24,
                        backgroundColor: Colors.orangeAccent,
                        backgroundImage: NetworkImage('${defaultUrl}'),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(12.0, 0.0, 15.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: (375.0 - 125),
                              child: Text(
                                progs.title,
                                style: textStyle(18),
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            SizedBox(
                              width: (375.0 - 125),
                              child: Text(
                                progs.description,
                                style: textStyle(14),
                                softWrap: true,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              ('On $formattedDate'),
                              style: textStyle(16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProgInfoPage(
                                programInfo: progs,
                              )));
                },
              ),
            ),
          ),
          Divider(
            height: 4.0,
          )
        ],
      ),
    );
  }
}

class DirList extends StatelessWidget {
  Artiste artiste;
  String imageUrl = Urls().image();
  String defaultUrl = Urls().defaultArtisteImage();
  DirList({this.artiste});
  @override
  Widget build(BuildContext context) {
    if (artiste.artiste_image.isNotEmpty) {
      defaultUrl = imageUrl + artiste.artiste_image;
    } else {
      defaultUrl = Urls().defaultArtisteImage();
    }
    TextStyle textStyle(double size) => TextStyle(
        fontSize: size,
        color: Colors.grey[600],
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic);
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
      child: Column(
        children: [
          Container(
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      minRadius: 24,
                      backgroundColor: Colors.orangeAccent,
                      backgroundImage: NetworkImage(defaultUrl),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 0.0, 15.0, 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: (375.0 - 125),
                            child: Text(
                              artiste.artiste_name,
                              style: textStyle(18),
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          SizedBox(
                            width: (375.0 - 125),
                            child: Text(
                              'Specilization: ${artiste.artiste_instrument}',
                              style: textStyle(14),
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ArtisteInfoPage(
                              artisteInfo: artiste,
                            )));
              },
            ),
          ),
          Divider(
            height: 4.0,
          )
        ],
      ),
    );
  }
}

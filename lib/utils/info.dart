import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:sunaad/data/urls.dart';
import 'package:sunaad/models/artiste.dart';
import 'package:sunaad/models/programs.dart';
import 'package:sunaad/models/venue.dart';
import 'package:url_launcher/url_launcher.dart';

// By Programs Info Page
class ProgInfoPage extends StatefulWidget {
  Programs programInfo;
  ProgInfoPage({
    this.programInfo,
  });

  @override
  _ProgInfoPageState createState() => _ProgInfoPageState();
}

class _ProgInfoPageState extends State<ProgInfoPage> {
  String imageUrl = Urls().image();

  String defaultUrl = Urls().defaultArtisteImage();
  @override
  Widget build(BuildContext context) {
    String url = widget.programInfo.entry_fee;
    setState(() {
      //url = url.replaceAll('<a href="', '');
      //url = url.replaceAll('">Click here </a>', '');
      //url = url.replaceAll('">Register here </a>', '');
      url = url.substring(url.indexOf("\"") + 1, url.lastIndexOf("\""));
    });

    if (widget.programInfo.artiste_image.isNotEmpty) {
      defaultUrl = imageUrl + widget.programInfo.artiste_image;
    } else {
      defaultUrl = Urls().defaultArtisteImage();
    }

    var formatter = DateFormat('dd-MM-yyyy');
    var formatterTime = DateFormat('hh:mm a');
    String formattedDate = formatter.format(widget.programInfo.event_date);
    String formattedTime = formatterTime.format(widget.programInfo.event_date);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Event",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Container(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.location_pin,
                          color: Colors.white,
                        )),
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  width: 6.0,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Container(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.fastfood,
                          color: Colors.white,
                        )),
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  width: 6.0,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Container(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.local_parking,
                          color: Colors.white,
                        )),
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  width: 6.0,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Container(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.timer,
                          color: Colors.white,
                        )),
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  width: 6.0,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: InkWell(
                    onTap: () async {
                      _launchURL(url.trim());
                    },
                    child: Container(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.public,
                            color: Colors.white,
                          )),
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(54, 14, 54, 26),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.network(defaultUrl,
                  height: 300.0, width: 300.0, fit: BoxFit.cover),
            ),
          ),
          Text(
            widget.programInfo.title,
            style: TextStyle(color: Colors.grey[600], fontSize: 18),
          ),
          SizedBox(
            height: 14,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              widget.programInfo.description,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 14,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0.0),
            child: Text(
              'On ${formattedDate}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Text(
              'At ${formattedTime}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            child: Text(
              'Venue: ${widget.programInfo.venue_name}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Text(
              'Organizer: ${widget.programInfo.organizer_name}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16.0),
          FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            color: Theme.of(context).primaryColor,
            onPressed: () async {
              _launchURL(url.trim());
            },
            child: Text(
              'ENTER',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(height: 36.0),
        ]),
      ),
    );
  }

  _launchURL(String url) async {
    print(url);
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

// Artiste Dir Info Page
class ArtisteInfoPage extends StatefulWidget {
  Artiste artisteInfo;
  ArtisteInfoPage({
    this.artisteInfo,
  });

  @override
  _ArtisteInfoPageState createState() => _ArtisteInfoPageState();
}

class _ArtisteInfoPageState extends State<ArtisteInfoPage> {
  String imageUrl = Urls().image();

  String defaultUrl = Urls().defaultArtisteImage();
  @override
  Widget build(BuildContext context) {
    if (widget.artisteInfo.artiste_image.isNotEmpty) {
      defaultUrl = imageUrl + widget.artisteInfo.artiste_image;
    } else {
      defaultUrl = defaultUrl = Urls().defaultArtisteImage();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Artiste",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
          SizedBox(
            height: 14,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(54, 14, 54, 26),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.network(defaultUrl,
                  height: 300.0, width: 300.0, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.artisteInfo.artiste_name.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 38,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 14,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Text(
              '${widget.artisteInfo.artiste_name} is ${widget.artisteInfo.artiste_desc}.',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 24.0),
          Text(
            'Connect'.toUpperCase(),
            style:
                TextStyle(color: Colors.grey[400], fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: InkWell(
                    onTap: () async {
                      if (widget.artisteInfo.artiste_email.isNotEmpty) {
                        String url =
                            'mailto:${widget.artisteInfo.artiste_email}?subject=&body=';
                        _launchURL(url);
                      }
                    },
                    child: Container(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.mail,
                            color: Colors.white,
                          )),
                      color: widget.artisteInfo.artiste_email.isNotEmpty
                          ? Colors.red
                          : Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  width: 6.0,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: InkWell(
                    onTap: () async {
                      if (widget.artisteInfo.artiste_phone.isNotEmpty) {
                        String url =
                            'tel:<${widget.artisteInfo.artiste_phone}>';
                        _launchURL(url);
                      }
                    },
                    child: Container(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.call,
                            color: Colors.white,
                          )),
                      color: widget.artisteInfo.artiste_phone.contains('ph_')
                          ? Colors.grey
                          : Colors.green,
                    ),
                  ),
                ),
                SizedBox(
                  width: 6.0,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: InkWell(
                    onTap: () async {
                      if (widget.artisteInfo.artiste_website.isNotEmpty) {
                        _launchURL(widget.artisteInfo.artiste_website);
                      }
                    },
                    child: Container(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.public,
                            color: Colors.white,
                          )),
                      color: widget.artisteInfo.artiste_website.isNotEmpty
                          ? Colors.blue
                          : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 36.0),
        ]),
      ),
    );
  }

  _launchURL(String url) async {
    print(url);
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

// Venue Dir Info Page
class VenueInfoPage extends StatefulWidget {
  Venue venueInfo;
  VenueInfoPage({
    this.venueInfo,
  });

  @override
  _VenueInfoPageState createState() => _VenueInfoPageState();
}

class _VenueInfoPageState extends State<VenueInfoPage> {
  String imageUrl = Urls().image();

  String defaultUrl = Urls().defaultArtisteImage();
  @override
  Widget build(BuildContext context) {
    if (widget.venueInfo.venue_image.isNotEmpty) {
      defaultUrl = imageUrl + widget.venueInfo.venue_image;
    } else {
      defaultUrl = defaultUrl = Urls().defaultArtisteImage();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Venue",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
          SizedBox(
            height: 14,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(54, 14, 54, 26),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.network(defaultUrl,
                  height: 300.0, width: 300.0, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.venueInfo.venue_name.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 38,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 14,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Text(
              '${widget.venueInfo.venue_name} is ${widget.venueInfo.venue_desc}.',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 24.0),
          Text(
            'Connect'.toUpperCase(),
            style:
                TextStyle(color: Colors.grey[400], fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: InkWell(
                    onTap: () async {
                      if (widget.venueInfo.venue_email.isNotEmpty) {
                        String url =
                            'mailto:${widget.venueInfo.venue_email}?subject=&body=';
                        _launchURL(url);
                      }
                    },
                    child: Container(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.mail,
                            color: Colors.white,
                          )),
                      color: widget.venueInfo.venue_email.isNotEmpty
                          ? Colors.red
                          : Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  width: 6.0,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: InkWell(
                    onTap: () async {
                      if (widget.venueInfo.venue_phone.isNotEmpty) {
                        String url = 'tel:<${widget.venueInfo.venue_phone}>';
                        _launchURL(url);
                      }
                    },
                    child: Container(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.call,
                            color: Colors.white,
                          )),
                      color: widget.venueInfo.venue_phone.contains('ph_')
                          ? Colors.grey
                          : Colors.green,
                    ),
                  ),
                ),
                SizedBox(
                  width: 6.0,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: InkWell(
                    onTap: () async {
                      if (widget.venueInfo.venue_website.isNotEmpty) {
                        _launchURL(widget.venueInfo.venue_website);
                      }
                    },
                    child: Container(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.public,
                            color: Colors.white,
                          )),
                      color: widget.venueInfo.venue_website.isNotEmpty
                          ? Colors.blue
                          : Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  width: 6.0,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: InkWell(
                    onTap: () async {
                      if (widget.venueInfo.venue_website.isNotEmpty) {
                        MapsLauncher.launchQuery(
                            widget.venueInfo.venue_mapcoords);
                        //_launchURL("https://maps.google.com/maps/search/?api=$map_api&query=${widget.venueInfo.venue_mapcoords}");
                      }
                    },
                    child: Container(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.map,
                            color: Colors.white,
                          )),
                      color: widget.venueInfo.venue_mapcoords.isNotEmpty
                          ? Colors.amber
                          : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 36.0),
        ]),
      ),
    );
  }

  _launchURL(String url) async {
    print(url);
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

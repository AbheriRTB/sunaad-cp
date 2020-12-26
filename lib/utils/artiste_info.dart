import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:sunaad/data/urls.dart';
import 'package:sunaad/models/artiste.dart';
import 'package:sunaad/models/programs.dart';
import 'package:url_launcher/url_launcher.dart';

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
                      color: widget.artisteInfo.artiste_phone.isNotEmpty
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
                      color: widget.artisteInfo.artiste_phone.isNotEmpty
                          ? Colors.green
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

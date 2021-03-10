import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sunaad/data/jason_data.dart';
import 'package:sunaad/assets/urls.dart';
import 'package:sunaad/utils/drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sunaad/models/programs.dart';
import 'package:sunaad/utils/menu.dart';

class BannerPage extends StatefulWidget {
  @override
  _BannerPageState createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  CarouselSlider carouselSlider;
  bool loading = true;
  String imageUrl = Urls().image();

  List<Programs> progs;
  Set bannerSet = Set();
  List banners = List();
  String organizer = 'Organizer';

  List map(List list, Function handler) {
    List result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sunaad",
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
        pos: 0,
      ),
      body: Center(
        child: FutureBuilder<List<Programs>>(
          future: JasonData().parseProgramsFromSPData(),
          builder: (context, snapshot) {
            bringArtiste(snapshot);
            print('Org ' + organizer);
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  carouselSlider = CarouselSlider(
                    options: CarouselOptions(
                      height: height - 142,
                      initialPage: 0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      reverse: false,
                      viewportFraction: 1.0,
                      enableInfiniteScroll: true,
                      autoPlayInterval: Duration(seconds: 5),
                      autoPlayAnimationDuration: Duration(milliseconds: 2000),
                      pauseAutoPlayOnTouch: true,

                      //pauseAutoPlayOnTouch: Duration(seconds: 10),
                      scrollDirection: Axis.horizontal,
                      /* onPageChanged: (index) {
                                    setState(() {
                                      _current = index;
                                    });
                                  },*/
                    ),
                    items: banners.map((imgUrl) {
                      return Builder(
                        builder: (BuildContext context) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Image.network(imgUrl, loadingBuilder:
                                      (BuildContext context, Widget child,
                                          ImageChunkEvent loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SpinKitRotatingPlain(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      size: 50.0,
                                    ),
                                    SizedBox(
                                      height: 16.0,
                                    ),
                                    Text(
                                      organizer,
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 18.0),
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(
                                      'Splash Loading...',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                      ),
                                    )
                                  ],
                                ));
                              }
                                  //fit: BoxFit.fill,
                                  ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  bringArtiste(AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      loading = false;
      for (int i = 0; i < snapshot.data.length; ++i) {
        String url = snapshot.data[i].splash_url;

        url = url.replaceAll('.html', '.jpg');
        url = url.replaceAll('flyer_', '');
        print('Url: ' + url);
        print(i);
        if (snapshot.data[i].is_featured == 'Yes') {
          organizer = snapshot.data[i].organizer_name;
          print(organizer);
          bannerSet.add(imageUrl + url);
          banners = bannerSet.toList();
        }
      }
    }
  }
}

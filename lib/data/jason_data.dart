import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunaad/data/urls.dart';
import 'package:sunaad/models/artiste.dart';
import 'package:sunaad/models/programs.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class JasonData {
  Future<List<Programs>> fetchPrograms(http.Client client) async {
    return fetchPrograms2(client);
  }

  List<Programs> parsePhotosWithoutAsync(String responce) {
    return parseProgramsSync2(responce);
  }

  Future<List<Programs>> parsePhotosFromSPData() async {
    return parseProgramsFromSPData2();
  }

  Future<List<Artiste>> fetchDir(http.Client client) async {
    return fetchDir2(client);
  }

  Future<List<Artiste>> parseArtisteFromSPData() async {
    return parseArtisteFromSPData2();
  }
}

Future<List<Programs>> fetchPrograms2(http.Client client) async {
  final response = await client.get(Urls().program());

  // Use the compute function to run parsePhotos in a separate isolate.
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.getString('progsData');
  prefs.setString('progsData', response.body);

  return compute(parsePrograms, response.body);
}

// A function that converts a response body into a List<Photo>.
Future<List<Programs>> parsePrograms(String responseBody) async {
  final parsed = await jsonDecode(responseBody).cast<Map<String, dynamic>>();

  List<Programs> plist, newList;

  plist = parsed.map<Programs>((json) => Programs.fromJson(json)).toList();
  newList = processExpiredItems(plist);
  return newList;
}

// A function that converts a response body into a List<Photo>.
Future<List<Programs>> parseProgramsFromSPData2() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var respBody = prefs.getString("progsData");
  List<Programs> plist, newList;
  final parsed = jsonDecode(respBody).cast<Map<String, dynamic>>();
  plist = parsed.map<Programs>((json) => Programs.fromJson(json)).toList();
  newList = processExpiredItems(plist);

  return newList;
}

List<Programs> parseProgramsSync2(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  List<Programs> plist, newList;

  plist = parsed.map<Programs>((json) => Programs.fromJson(json)).toList();
  newList = processExpiredItems(plist);
  return newList;
}

List<Programs> processExpiredItems(List<Programs> plist) {
  var experyDate = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day - 3);

  List<Programs> newList = List<Programs>();

  for (var i = 0; i < plist.length; ++i) {
    if (!experyDate.isAfter(plist[i].event_date) &&
        plist[i].is_published != 'No') {
      newList.add(plist[i]);
    }
  }
  return newList;
  //print("Length after:" + plist.length.toString());
}

List<Artiste> processPublishedItems(List<Artiste> plist) {
  var experyDate = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day - 3);

  List<Artiste> newList = List<Artiste>();

  for (var i = 0; i < plist.length; ++i) {
    if (plist[i].artiste_instrument != 'No') {
      newList.add(plist[i]);
    }
  }
  return newList;
  //print("Length after:" + plist.length.toString());
}

Future<List<Artiste>> fetchDir2(http.Client client) async {
  final response = await client.get(Urls().artiste());

  // Use the compute function to run parsePhotos in a separate isolate.
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.getString('artisteData');
  prefs.setString('artisteData', response.body);

  return compute(parseArtisteDir, response.body);
}

// A function that converts a response body into a List<Artiste>.
Future<List<Artiste>> parseArtisteDir(String responseBody) async {
  final parsed = await jsonDecode(responseBody).cast<Map<String, dynamic>>();

  List<Artiste> plist, newList;
  plist = parsed.map<Artiste>((json) => Artiste.fromJson(json)).toList();
  newList = processPublishedItems(plist);
  return newList;
}

List<Artiste> parseArtisteSync2(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  List<Artiste> plist, newList;
  plist = parsed.map<Artiste>((json) => Artiste.fromJson(json)).toList();
  newList = processPublishedItems(plist);
  return newList;
}

// A function that converts a response body into a List<Photo>.
Future<List<Artiste>> parseArtisteFromSPData2() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var respBody = prefs.getString("artisteData");
  List<Artiste> plist, newList;
  final parsed = jsonDecode(respBody).cast<Map<String, dynamic>>();
  plist = parsed.map<Artiste>((json) => Artiste.fromJson(json)).toList();
  newList = processPublishedItems(plist);
  return newList;
}

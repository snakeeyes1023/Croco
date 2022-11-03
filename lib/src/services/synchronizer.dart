import 'dart:io';
import 'package:m3u/m3u.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:mysql1/mysql1.dart';
import 'enums/M3UcontentType.dart';

class Synchronizer {
  late ConnectionSettings connectionSettings;

  Synchronizer() {
    connectionSettings = ConnectionSettings(
        host: '70.32.23.53',
        port: 3306,
        user: 'jonath37_CrocoBeta',
        password: '~B~_5@qtzW==',
        db: 'jonath37_CrocoBeta');
  }

  /**
   * Read the m3u files and return the all movies
   */
  Future<List<M3uGenericEntry>> exportM3u() async {
    final source = await rootBundle.loadString('assets/m3ufile.m3u');
    //final source = ""
    return await M3uParser.parse(source);
  }

  Future<void> insertInDb() async {
    // get export m3u
    var m3uLinks = await exportM3u();

    /*!SECTION: INSERTION */
    // test insert
    var conn = await MySqlConnection.connect(connectionSettings);

    // insert all m3ulimks in db
    for (var m3uLink in m3uLinks) {
      // get the content type

      // insert the link in db
      await conn.query(
          'INSERT INTO Movie (title, link, poster) VALUES (?, ?, ?)',
          [m3uLink.title, m3uLink.link, "none"]);
    }

/*
    var conn = await MySqlConnection.connect(connectionSettings);
    await conn.query("INSERT INTO Movie (title, link, poster) VALUES (?, ?, ?)",
        [m3uLinks[1].title, m3uLinks[1].link, "aucun"]);

    // insert all movies
    var movies = getContentByType(M3UContentType.Movie, await m3uLinks);

    movies.forEach((element) async {
      var conn = await MySqlConnection.connect(connectionSettings);

      await conn.query(
          "INSERT INTO Movie (title, link, poster) VALUES (?, ?, ?)",
          [element.title, element.link, "aucun"]);

      await conn.close();
    });
    await conn.queryMulti(
        "INSERT INTO series (name, link, group) VALUES (?, ?, ?)",
        [getContentByType(M3UContentType.Series, await m3uLinks)]);

    await conn.queryMulti(
        "INSERT INTO tvChannels (name, link, group) VALUES (?, ?, ?)",
        [getContentByType(M3UContentType.TvShow, await m3uLinks)]);
  */
  }

  /**
   * Filter the content to get only the type pass in parameter
   */
  List<M3uGenericEntry> getContentByType(
      M3UContentType contentType, List<M3uGenericEntry> contents) {
    if (contentType == M3UContentType.Movie) {
      return contents
          .where((element) => element.attributes["group-title"]!
              .toLowerCase()
              .contains('movie'))
          .toList();
    }

    if (contentType == M3UContentType.Series) {
      return contents
          .where((element) =>
              element.attributes["group-title"]!
                  .toLowerCase()
                  .contains('series') ||
              element.attributes["group-title"]!.toLowerCase().contains('tv'))
          .toList();
    }

    if (contentType == M3UContentType.TvShow) {
      return contents
          .where((element) =>
              element.attributes["tvg-id"]!.toLowerCase().isNotEmpty)
          .toList();
    }

    throw new Exception("type de contentnu non implémenté");
  }
}

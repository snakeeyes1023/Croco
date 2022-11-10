import 'dart:io';
import 'package:m3u/m3u.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mysql1/mysql1.dart';
import 'enums/content_type_enum.dart';
import 'package:dio/dio.dart';

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

  Future addNewLink(linkM3U) async {
    var conn = await MySqlConnection.connect(connectionSettings);

    await conn.query('INSERT INTO M3ULink (link) VALUES (?)', linkM3U);

    await conn.close();

    await exportM3u(linkM3U);
  }

  /// Read the m3u files and return the all movies
  Future<List<M3uGenericEntry>> exportM3u(m3uUrl) async {
    var response = await Dio().get(m3uUrl);
    return await M3uParser.parse(response.toString());
  }

  Future<void> insertInDb(m3uUrl) async {
    // get export m3u
    var m3uLinks = exportM3u(m3uUrl);

    Iterable<List<Object?>> movieToInsert =
        getContentByType(ContentTypeEnum.movie, await m3uLinks)
            .map((e) => [e.title, e.link, e.attributes['tvg-logo']])
            .toList();

    var conn = await MySqlConnection.connect(connectionSettings);

    // movie in db
    await conn.queryMulti(
        'INSERT INTO Movie (title, link, poster) VALUES (?, ?, ?)',
        movieToInsert);

    await conn.close();
  }

  /// Filter the content to get only the type pass in parameter
  List<M3uGenericEntry> getContentByType(
      ContentTypeEnum contentType, List<M3uGenericEntry> contents) {
    if (contentType == ContentTypeEnum.movie) {
      return contents
          .where((element) => element.attributes["group-title"]!
              .toLowerCase()
              .contains('movie'))
          .toList();
    }

    if (contentType == ContentTypeEnum.series) {
      return contents
          .where((element) =>
              element.attributes["group-title"]!
                  .toLowerCase()
                  .contains('series') ||
              element.attributes["group-title"]!.toLowerCase().contains('tv'))
          .toList();
    }

    if (contentType == ContentTypeEnum.tvShow) {
      return contents
          .where((element) =>
              element.attributes["tvg-id"]!.toLowerCase().isNotEmpty)
          .toList();
    }

    throw Exception("type de contentnu non implémenté");
  }
}

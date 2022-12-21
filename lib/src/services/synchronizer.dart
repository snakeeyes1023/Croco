import 'dart:io';
import 'package:m3u/m3u.dart';
import 'package:mysql1/mysql1.dart';
import 'enums/content_type_enum.dart';
import 'package:dio/dio.dart';
import 'connection.dart';

class Synchronizer {
  late ConnectionSettings connectionSettings;

  Synchronizer() {
    connectionSettings = Connection.getRemoteMysqlConnectionSettings();
  }

  Future<bool> addNewLink(linkM3U) async {
    try {
      if (!(await isValidLink(linkM3U))) {
        throw Exception("Le lien n'est pas valide");
      }

      var conn = await MySqlConnection.connect(connectionSettings);

      await conn.query('INSERT INTO M3ULink (link) VALUES (?)', [linkM3U]);

      await conn.close();

      await insertInDb(linkM3U);

      return true;
    } catch (e) {
      print("Impossible de syncroniser les films" + e.toString());

      return false;
    }
  }

  Future<bool> isValidLink(m3uUrl) async {
    try {
      var response = await Dio().get(m3uUrl);
      return response.statusCode == HttpStatus.ok &&
          (await M3uParser.parse(response.toString())).isNotEmpty;
    } catch (e) {
      return false;
    }
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
          .where((element) =>
              element.attributes["group-title"]!
                  .toLowerCase()
                  .contains('movie') ||
              element.link!.toLowerCase().contains('movie'))
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

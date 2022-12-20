import 'dart:io';
import 'package:mysql1/mysql1.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tmdb_api/tmdb_api.dart';

class Connection {
  static ConnectionSettings? _connectionSettings;
  static TMDB? _tmdb;

  static Future loadSettings() async {
    await dotenv.load(fileName: ".env");

    _connectionSettings = ConnectionSettings(
        host: dotenv.env['DB_HOST']!,
        port: int.parse(dotenv.env['DB_PORT']!),
        user: dotenv.env['DB_USER']!,
        password: dotenv.env['DB_PASSWORD']!,
        db: dotenv.env['DB_DATABASE']!);

    ApiKeys apiKeys =
        ApiKeys(dotenv.env['TMDB_KEY']!, dotenv.env['TMDB_TOKENV4']!);

    _tmdb = TMDB(apiKeys);
  }

  static ConnectionSettings getRemoteMysqlConnectionSettings() {
    return _connectionSettings ?? ConnectionSettings();
  }

  static TMDB getTmdbInstance() {
    ApiKeys apiKeys =
        ApiKeys(dotenv.env['TMDB_KEY']!, dotenv.env['TMDB_TOKENV4']!);

    return TMDB(apiKeys);
  }
}

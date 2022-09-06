import 'dart:io';
import 'package:m3u/m3u.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'enums/M3UcontentType.dart';

class CommonCache {
  late Duration _cacheValidDuration;
  late DateTime _lastFetchTime;
  late List<M3uGenericEntry> _allRecords;
  late List<M3uGenericEntry>? _movies;
  late List<M3uGenericEntry>? _series;
  List<String>? _movieCategories;
  List<String>? _seriesCategories;
  List<String>? _tvCategories;

/*static const String _m3uUrl =
      'https://iptv-org.github.io/iptv/languages/tha.m3u';*/
  static const String _m3uUrl =
      'https://recipeweb.jonathancote.ca/tv_channels_KFH2HwxYrbMB_plus.m3u';
  CommonCache() {
    _cacheValidDuration = Duration(days: 1);
    _lastFetchTime = DateTime.fromMillisecondsSinceEpoch(0);
    _allRecords = [];
  }

  Future<CommonCache> fillCache({bool forceRefresh = false}) async {
    bool shouldRefreshFromApi = (_allRecords.isEmpty || forceRefresh);

    if (shouldRefreshFromApi) {
      await exportM3u();
      _lastFetchTime = DateTime.fromMillisecondsSinceEpoch(0);
    }

    return this;
  }

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/m3ufile.m3u');
  }

  Future<void> exportM3u() async {
    /*final response = await http.get(Uri.parse(_m3uUrl));

    _allRecords = await M3uParser.parse(response.body);*/

    final source = await loadAsset();
    _allRecords = await M3uParser.parse(source);
  }

  Future<List<M3uGenericEntry>> getMovies() async {
    await fillCache();

    _movies ??= _allRecords
        .where((element) =>
            element.attributes["group-title"]!.toLowerCase().contains('movie'))
        .toList();

    return _movies!;
  }

  Future<List<M3uGenericEntry>> getSeries() async {
    await fillCache();

    _series ??= _allRecords
        .where((element) =>
            element.attributes["group-title"]!
                .toLowerCase()
                .contains('series') ||
            element.attributes["group-title"]!.toLowerCase().contains('tv'))
        .toList();

    return _series!;
  }

  Future<List<M3uGenericEntry>> getAll() async {
    await fillCache();

    return _allRecords;
  }

  Future<List<String>> getGroupNames(M3UContentType contentType) async {
    await fillCache();

    if (contentType == M3UContentType.Movie) {
      _movieCategories ??= _allRecords
          .where((element) =>
              !element.attributes["group-title"]!
                  .toLowerCase()
                  .contains('series') &&
              !element.attributes["tvg-id"]!.isNotEmpty)
          .map((e) => e.attributes["group-title"]!)
          .toSet()
          .toList();

      _movieCategories?.removeWhere((item) => item.isEmpty);

      return _movieCategories!;
    }

    if (contentType == M3UContentType.Series) {
      _seriesCategories ??= _allRecords
          .where((element) => element.attributes["group-title"]!
              .toLowerCase()
              .contains('series'))
          .map((e) => e.attributes["group-title"]!)
          .toSet()
          .toList();

      _seriesCategories?.removeWhere((item) => item.isEmpty);

      return _seriesCategories!;
    }

    if (contentType == M3UContentType.TvShow) {
      _tvCategories ??= _allRecords
          .where((element) =>
              element.attributes["tvg-id"]!.toLowerCase().isNotEmpty)
          .map((e) => e.attributes["group-title"]!)
          .toSet()
          .toList();

      _tvCategories?.removeWhere((item) => item.isEmpty);

      return _tvCategories!;
    }

    return [];
  }

  Future<List<M3uGenericEntry>> getGroup(String groupName) async {
    await fillCache();

    return _allRecords
        .where((element) =>
            element.attributes["group-title"]
                ?.toLowerCase()
                .contains(groupName) ??
            false)
        .toList();
  }

  getM3uUrl() {
    return _m3uUrl;
  }
}

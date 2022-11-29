import 'package:tmdb_api/tmdb_api.dart';

class FavoriteMovie {
  final int id;
  final int remoteId;
  final bool isFavorite;

  FavoriteMovie(this.id, this.remoteId, this.isFavorite);

  // from map
  FavoriteMovie.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        remoteId = map['remoteId'],
        isFavorite = map['isFavorite'] == 1;

  // to map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'remoteId': remoteId,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }

  @override
  String toString() {
    return 'FavoriteMovie{id: $id, remoteId: $remoteId, isFavorite: $isFavorite}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteMovie &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          remoteId == other.remoteId &&
          isFavorite == other.isFavorite;

  @override
  int get hashCode => id.hashCode ^ remoteId.hashCode ^ isFavorite.hashCode;
}

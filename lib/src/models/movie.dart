class Movie {
  final String title;
  final String link;
  final String poster;
  final int id;

  //get movie name split FR| Bobby, seul contre tous
  String get splittedTitle {
    var split = title.split("|");
    return split.last.trim();
  }

  Movie(this.id, this.title, this.link, this.poster);

  @override
  String toString() {
    return 'Movie{title: $title, link: $link, poster: $poster}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Movie &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          link == other.link &&
          poster == other.poster;

  @override
  int get hashCode => title.hashCode ^ link.hashCode ^ poster.hashCode;
}

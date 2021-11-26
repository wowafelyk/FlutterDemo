class VideoEntity {
  VideoEntity({
    required this.year,
    required this.type,
    required this.imdbID,
    required this.name,
    required this.poster,
  });

  final String name;
  final String poster;
  final String year;
  final String type;
  final String imdbID;
}

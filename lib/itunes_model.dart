class Track {
  final String trackName;
  final String artistName;
  final String collectionName;
  final String artworkUrl60;
  final String artworkUrl100;
  final String artworkUrl600;
  final String wrapperType;
  final int trackTimeMillis;
  final String description ;
  final String longDescription ;
  final String shortDescription ;
  final String previewUrl ;
  final List<dynamic> genres;

  Track(
      {this.artistName,
      this.artworkUrl60,
      this.artworkUrl100,
      this.artworkUrl600,
      this.collectionName,
      this.genres,
      this.trackName,
      this.wrapperType,
      this.description,
      this.longDescription,
      this.shortDescription,
      this.previewUrl,
      this.trackTimeMillis});

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      artistName: json['artistName'] ?? null,
      trackName: json['trackName'] ?? null,
      collectionName: json['collectionName'] ?? null,
      artworkUrl60: json['artworkUrl60'] ?? null,
      artworkUrl100: json['artworkUrl100'] ?? null,
      artworkUrl600: json['artworkUrl600'] ?? null,
      wrapperType: json['wrapperType'] ?? null,
      genres: json['genres'] ?? null,
      trackTimeMillis: json['trackTimeMillis'] ?? null,
      description: json['description'] ?? null,
      longDescription:  json['longDescription'] ?? null,
      shortDescription: json['shortDescription'] ?? null,
      previewUrl: json['previewUrl'] ?? null,
    );
  }
}
import 'dart:convert';

import 'package:ggame/data/local/ggame_db.dart';
import 'package:intl/intl.dart';

import 'info.dart';
import 'minimum_system.dart';
import 'screenshot.dart';

Game gameFromJson(String str) => Game.fromJson(json.decode(str));

List<Game> listGameFromJson(String str) =>
    List<Game>.from(json.decode(str).map((x) => Game.fromJson(x)));

class Game {
  int id;
  String title,
      thumbnail,
      status,
      shortDescription,
      description,
      gameUrl,
      genre,
      platform,
      publisher,
      developer,
      freetogameProfileUrl,
      releaseDate;
  MinimumSystemRequirements? minimumSystemRequirements;
  List<Screenshot>? screenshots;

  Game({
    required this.id,
    this.title = '',
    this.thumbnail = '',
    this.status = '',
    this.shortDescription = '',
    this.description = '',
    this.gameUrl = '',
    this.genre = '',
    this.platform = '',
    this.publisher = '',
    this.developer = '',
    this.releaseDate = '',
    this.freetogameProfileUrl = '',
    this.minimumSystemRequirements,
    this.screenshots,
  });

  factory Game.fromJson(Map<String, dynamic> json) => Game(
        id: json["id"] ?? '',
        title: json["title"] ?? '',
        thumbnail: json["thumbnail"] ?? '',
        status: json["status"] ?? '',
        shortDescription: json["short_description"] ?? '',
        description: json["description"] ?? '',
        gameUrl: json["game_url"] ?? '',
        genre: json["genre"] ?? '',
        platform: json["platform"] ?? '',
        publisher: json["publisher"] ?? '',
        developer: json["developer"] ?? '',
        releaseDate: json["release_date"] ?? '-',
        freetogameProfileUrl: json["freetogame_profile_url"],
        minimumSystemRequirements: json["minimum_system_requirements"] != null
            ? MinimumSystemRequirements.fromJson(
                json["minimum_system_requirements"])
            : MinimumSystemRequirements(),
        screenshots: json["screenshots"] != null
            ? List<Screenshot>.from(
                json["screenshots"].map((x) => Screenshot.fromJson(x)))
            : List.empty(),
      );

  String toReleaseDate({String? format}) {
    if (releaseDate.isNotEmpty) {
      var release = DateTime.parse(releaseDate);
      return DateFormat(format ?? 'MMMM yyyy').format(release);
    } else {
      return 'Tidak ada release date';
    }
  }

  List<Info> toAdditionalInfo() => [
        Info(title: "Platform", desc: platform),
        Info(title: "Status", desc: status),
        Info(title: "Developper", desc: developer),
        Info(title: "Publisher", desc: publisher),
      ];

  FavoriteData toFavorite() => FavoriteData(
      id: id, title: title, image: thumbnail, shortDesc: shortDescription);

  @override
  String toString() {
    return """
    Id = $id
    Title = $title
    Url = $gameUrl
    """;
  }
}

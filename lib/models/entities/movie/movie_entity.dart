import 'package:json_annotation/json_annotation.dart';
import 'package:movie_flutter_training/configs/app_configs.dart';

part 'movie_entity.g.dart';

@JsonSerializable()
class MovieEntity {
  @JsonKey()
  int? id;
  @JsonKey()
  String? title;
  @JsonKey(name: 'poster_path')
  String? posterPath;
  @JsonKey(name: 'backdrop_path')
  String? backdropPath;
  @JsonKey(name: 'vote_average')
  double? voteAverage;
  @JsonKey(name: 'original_title')
  String? originalTitle;
  @JsonKey()
  String? overview;
  @JsonKey(name: 'release_date')
  String? releaseDate;
  @JsonKey()
  List<Genre>? genres;
  @JsonKey()
  int? revenue;
  @JsonKey()
  int? runtime;

  MovieEntity({
    this.id,
    this.title,
    this.posterPath,
    this.backdropPath,
    this.voteAverage,
    this.originalTitle,
    this.overview,
    this.releaseDate,
    this.genres,
    this.revenue,
    this.runtime,
  });

  factory MovieEntity.fromJson(Map<String, dynamic> json) =>
      _$MovieEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MovieEntityToJson(this);

  @JsonKey(includeFromJson: false, includeToJson: false)
  String get posterPathUrl {
    return '${MovieAPIConfig.imageUrl}${posterPath ?? ""}';
  }
  String get backdropPathUrl {
    return '${MovieAPIConfig.imageUrl}${backdropPath ?? ""}';
  }
}

@JsonSerializable()
class Genre {
  @JsonKey()
  int? id;
  @JsonKey()
  String? name;

  Genre({
    this.id,
    this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
  Map<String, dynamic> toJson() => _$GenreToJson(this);
}


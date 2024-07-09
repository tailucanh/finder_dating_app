import 'package:json_annotation/json_annotation.dart';
part 'spotify_information_entity.g.dart';
@JsonSerializable()
class SpotifyInformationEntity {
  String albumImageUrl;
  String spotifyExternalUrl;
  String previewUrl;
  String name;
  List<String> artist;

  SpotifyInformationEntity({
    required this.albumImageUrl,
    required this.spotifyExternalUrl,
    required this.previewUrl,
    required this.name,
    required this.artist,
  });

  factory SpotifyInformationEntity.fromJson(Map<String, dynamic> json) =>
      _$SpotifyInformationEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SpotifyInformationEntityToJson(this);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spotify_information_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpotifyInformationEntity _$SpotifyInformationEntityFromJson(
        Map<String, dynamic> json) =>
    SpotifyInformationEntity(
      albumImageUrl: json['albumImageUrl'] as String,
      spotifyExternalUrl: json['spotifyExternalUrl'] as String,
      previewUrl: json['previewUrl'] as String,
      name: json['name'] as String,
      artist:
          (json['artist'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$SpotifyInformationEntityToJson(
        SpotifyInformationEntity instance) =>
    <String, dynamic>{
      'albumImageUrl': instance.albumImageUrl,
      'spotifyExternalUrl': instance.spotifyExternalUrl,
      'previewUrl': instance.previewUrl,
      'name': instance.name,
      'artist': instance.artist,
    };

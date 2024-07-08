// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistApiModel _$ArtistApiModelFromJson(Map<String, dynamic> json) =>
    ArtistApiModel(
      id: json['_id'] as String?,
      artistName: json['artistName'] as String,
      artistRate: (json['artistRate'] as num).toInt(),
      artistImage: json['artistImage'] as String,
      artistDescription: json['artistDescription'] as String,
      artistGenre: json['artistGenre'] as String,
    );

Map<String, dynamic> _$ArtistApiModelToJson(ArtistApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'artistName': instance.artistName,
      'artistRate': instance.artistRate,
      'artistImage': instance.artistImage,
      'artistDescription': instance.artistDescription,
      'artistGenre': instance.artistGenre,
    };

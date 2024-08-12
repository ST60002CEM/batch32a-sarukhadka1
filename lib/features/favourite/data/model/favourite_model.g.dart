// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Favourite _$FavouriteFromJson(Map<String, dynamic> json) => Favourite(
      id: json['_id'] as String,
      artist: ArtistApiModel.fromJson(json['artist'] as Map<String, dynamic>),
      user: AuthApiModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FavouriteToJson(Favourite instance) => <String, dynamic>{
      '_id': instance.id,
      'artist': instance.artist,
      'user': instance.user,
    };

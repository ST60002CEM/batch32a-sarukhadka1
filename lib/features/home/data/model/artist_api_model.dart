

import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/home/domain/entity/artist_entity.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'artist_api_model.g.dart';

//provider
final artistApiModelProvider =
    Provider<ArtistApiModel>((ref) => const ArtistApiModel.empty());

@JsonSerializable()
class ArtistApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String artistName;
  final int artistRate;
  final String artistImage;
  final String artistDescription;
  final String artistGenre;

  const ArtistApiModel({
    required this.id,
    required this.artistName,
    required this.artistRate,
    required this.artistImage,
    required this.artistDescription,
    required this.artistGenre,
  });

  const ArtistApiModel.empty()
      : id = '',
        artistName = '',
        artistRate = 0,
        artistImage = '',
        artistDescription = '',
        artistGenre = '';

  factory ArtistApiModel.fromJson(Map<String, dynamic> json) =>
      _$ArtistApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistApiModelToJson(this);

  // To Entity
  ArtistEntity toEntity() {
    return ArtistEntity(
      id: id,
      artistName: artistName,
      artistRate: artistRate,
      artistImage: artistImage,
      artistDescription: artistDescription,
      artistGenre: artistGenre,
    );
  }

  //Convert Entity to API Object
  factory ArtistApiModel.fromEntity(ArtistEntity entity) {
    return ArtistApiModel(
      id: entity.id,
      artistName: entity.artistName,
      artistRate: entity.artistRate,
      artistImage: entity.artistImage,
      artistDescription: entity.artistDescription,
      artistGenre: entity.artistGenre,
    );
  }

  //Convert API List to Entity List
  List<ArtistEntity> toEntityList(List<ArtistApiModel> artists) {
    return artists.map((artist) => artist.toEntity()).toList();
  }

  List<ArtistApiModel> fromEntityList(List<ArtistEntity> artists) {
    return artists.map((artist) => ArtistApiModel.fromEntity(artist)).toList();
  }

  @override
  List<Object?> get props => [
        id,
        artistName,
        artistRate,
        artistImage,
        artistDescription,
        artistGenre,
      ];
}

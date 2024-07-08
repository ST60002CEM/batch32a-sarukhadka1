import 'package:final_assignment/features/home/data/model/artist_api_model.dart';


import 'package:json_annotation/json_annotation.dart';

part 'pagination_dto.g.dart';

@JsonSerializable()
class PaginationDto {
  final bool success;
  final String message;
  final List<ArtistApiModel> artists;

  PaginationDto({
    required this.success,
    required this.message,
    required this.artists,
  });

  Map<String, dynamic> toJson() => _$PaginationDtoToJson(this);

  factory PaginationDto.fromJson(Map<String, dynamic> json) =>
      _$PaginationDtoFromJson(json);
}

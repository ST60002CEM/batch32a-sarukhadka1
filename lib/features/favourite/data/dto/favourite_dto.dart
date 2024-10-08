import 'package:final_assignment/features/favourite/data/model/favourite_model.dart';

class FavouriteDto {
  final bool success;
  final List<Favourite> data;

  FavouriteDto({required this.success, required this.data});

  // from json
  // factory FavouriteDto.fromJson(Map<String, dynamic> json) {
  //   return FavouriteDto(
  //     success: json['success'] ?? false,
  //     favorites: (json['favorites'] as List?)
  //         ?.map((artists) => Favourite.fromJson(artists))
  //         .toList() ?? [],
  //   );
  // }
  factory FavouriteDto.fromJson(Map<String, dynamic> json) {
    print(json['data']); // Add this line to see the parsed data
    return FavouriteDto(
      success: json['success'] ?? false,
      data: (json['data'] as List?)
              ?.map((artists) => Favourite.fromJson(artists))
              .toList() ??
          [],
    );
  }

  // to json
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.map((artists) => artists.toJson()).toList(),
    };
  }
}

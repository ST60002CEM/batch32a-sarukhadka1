import 'package:final_assignment/features/favourite/data/model/favourite_model.dart';

class FavouriteDto {
  final bool success;
  final List<Favourite> favorites;

  FavouriteDto({required this.success, required this.favorites});

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
    print(json['favorites']); // Add this line to see the parsed data
    return FavouriteDto(
      success: json['success'] ?? false,
      favorites: (json['favorites'] as List?)
              ?.map((artists) => Favourite.fromJson(artists))
              .toList() ??
          [],
    );
  }

  // to json
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'favorites': favorites.map((artists) => artists.toJson()).toList(),
    };
  }
}

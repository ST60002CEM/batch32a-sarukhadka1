
import 'package:final_assignment/features/favourite/data/model/favourite_model.dart';

class FavouriteDto {
  final bool success;
  final List<Favourite> favorites;

  FavouriteDto({required this.success, required this.favorites});

//   from json
  factory FavouriteDto.fromJson(Map<String, dynamic> json) {
    return FavouriteDto(
      success: json['success'],
      favorites: (json['favorites'] as List)
          .map((artist) => Favourite.fromJson(artist))
          .toList(),
    );
  }

//   to json
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'favorites': favorites.map((artist) => artist.toJson()).toList(),
    };
  }


}
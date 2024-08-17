import 'package:final_assignment/features/home/domain/entity/artist_entity.dart';

 
class SingleArtistState {
  final ArtistEntity? singleArtist;
  final bool isLoading;
  final String? error;
  final int selectedQuantity;
 
  SingleArtistState({
    required this.singleArtist,
    required this.isLoading,
    required this.error,
    required this.selectedQuantity,
  });
 
  factory SingleArtistState.initial() => SingleArtistState(
        singleArtist: null,
        isLoading: false,
        error: null,
        selectedQuantity: 1,
      );
 
  SingleArtistState copyWith({
    ArtistEntity? singleProduct,
    bool? isLoading,
    String? error,
    int? selectedQuantity,
  }) {
    return SingleArtistState(
      singleArtist: singleProduct ?? this.singleArtist,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      selectedQuantity: selectedQuantity ?? this.selectedQuantity,
    );
  }
}
 
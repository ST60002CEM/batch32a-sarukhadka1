import 'package:final_assignment/features/home/domain/entity/artist_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteArtistNotifier extends StateNotifier<List<ArtistEntity>> {
  FavoriteArtistNotifier() : super([]);

  void addArtist(ArtistEntity artist) {
    state = [...state, artist];
  }

  void removeArtist(ArtistEntity artist) {
    state = state.where((p) => p != artist).toList();
  }
}

final favoriteArtistProvider =
    StateNotifierProvider<FavoriteArtistNotifier, List<ArtistEntity>>(
        (ref) => FavoriteArtistNotifier());

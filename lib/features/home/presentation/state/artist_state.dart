

import 'package:final_assignment/features/home/domain/entity/artist_entity.dart';

class ArtistState {
  final List<ArtistEntity> artists;
  final bool hasReachedMax;
  final int page;
  final bool isLoading;

  ArtistState({
    required this.artists,
    required this.hasReachedMax,
    required this.page,
    required this.isLoading,
  });

  factory ArtistState.initial() {
    return ArtistState(
      artists: [],
      hasReachedMax: false,
      page: 0,
      isLoading: false,
    );
  }

  ArtistState copyWith({
    List<ArtistEntity>? artists,
    bool? hasReachedMax,
    int? page,
    bool? isLoading,
  }) {
    return ArtistState(
      artists: artists ?? this.artists,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

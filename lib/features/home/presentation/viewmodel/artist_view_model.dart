import 'package:dartz/dartz.dart';
import 'package:final_assignment/features/home/domain/usecases/artist_usecase.dart';
import 'package:final_assignment/features/home/presentation/state/artist_state.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final artistViewModelProvider =
    StateNotifierProvider<ArtistViewmodel, ArtistState>(
        (ref) => ArtistViewmodel(
              artistUsecase: ref.watch(artistUsecaseProvider),
            ));

class ArtistViewmodel extends StateNotifier<ArtistState> {
  ArtistViewmodel({required this.artistUsecase})
      : super(ArtistState.initial()) {
    getArtists();
  }

  final ArtistUseCase artistUsecase;

  Future resetState() async {
    state = ArtistState.initial();
    getArtists();
  }

  Future getArtists() async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final page = currentState.page + 1;
    final artists = currentState.artists;
    final hasReachedMax = currentState.hasReachedMax;
    if (!hasReachedMax) {
      // get data from data source
      final result = await artistUsecase.pagination(page, 6);
      result.fold(
        (failure) =>
            state = state.copyWith(hasReachedMax: true, isLoading: false),
        (data) {
          if (data.isEmpty) {
            state = state.copyWith(hasReachedMax: true);
          } else {
            state = state.copyWith(
              artists: [...artists, ...data],
              page: page,
              isLoading: false,
            );
          }
        },
      );
    }
  }
  
}




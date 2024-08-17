import 'package:final_assignment/core/common/show_my_snackbar.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/home/domain/usecases/artist_usecase.dart';
import 'package:final_assignment/features/single_artist/presentation/state/single_artist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final singleArtistViewModelProvider =
    StateNotifierProvider<SingleArtistViewModel, SingleArtistState>(
        (ref) => SingleArtistViewModel(
              artistUsecase: ref.watch(artistUsecaseProvider),
              userSharedPrefs: ref.watch(userSharedPrefsProvider),
            ));

class SingleArtistViewModel extends StateNotifier<SingleArtistState> {
  SingleArtistViewModel({
    required this.artistUsecase,
    required this.userSharedPrefs,
  }) : super(SingleArtistState.initial());

  final ArtistUseCase artistUsecase;
  final UserSharedPrefs userSharedPrefs;

  Future<void> getSingleArtist(String artistId) async {
    state = state.copyWith(isLoading: true);
    final result = await artistUsecase.getArtistById(artistId);
    result.fold((failure) {
      state = state.copyWith(isLoading: false, error: failure.error);
      showMySnackBar(message: failure.error,color: Colors.red);
    }, (data) {
      state = state.copyWith(
        isLoading: false,
        singleProduct: data,
        error: null,
      );
    });
  }

  void updateSelectedQuantity(int quantity) {
    if (state.singleArtist != null &&
        quantity > state.singleArtist!.artistRate) {
      showMySnackBar(message: 'Out of stock', color: Colors.red);
      return;
    }
    if (quantity < 1) {
      showMySnackBar(
          message: 'Quantity cannot be less 1', color: Colors.red);
      return;
    }
    state = state.copyWith(selectedQuantity: quantity);
  }
}

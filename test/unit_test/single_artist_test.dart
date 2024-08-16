import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/home/domain/entity/artist_entity.dart';
import 'package:final_assignment/features/home/domain/usecases/artist_usecase.dart';
import 'package:final_assignment/features/single_artist/presentation/viewmodel/single_artist_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'single_artist_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ArtistUseCase>()])
void main() {
  late ArtistUseCase mockArtistUseCase;
  late ProviderContainer container;

  setUp(() {
    mockArtistUseCase = MockArtistUseCase();
    container = ProviderContainer(
      overrides: [
        singleArtistViewModelProvider.overrideWith(
          (ref) => SingleArtistViewModel(
            artistUsecase: mockArtistUseCase,
            userSharedPrefs: ref.watch(userSharedPrefsProvider),
          ),
        ),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('getSingleArtyist should correctly fetch and update state', () async {
    // Arrange
    final artistId = '1';
    const artist = ArtistEntity(
      id: '1',
      artistName: 'Artist 1',
      artistRate: 10000,
      artistGenre: 'Party',
      artistDescription: ' Nice ',
      artistImage: 'image1.jpg',
    );

    when(mockArtistUseCase.getArtistById(artistId))
        .thenAnswer((_) async => const Right(artist));

    final viewModel = container.read(singleArtistViewModelProvider.notifier);

    // Act
    await viewModel.getSingleArtist(artistId);

    // Assert
    final state = container.read(singleArtistViewModelProvider);
    expect(state.isLoading, false);
    expect(state.singleArtist, isNotNull);
    expect(state.singleArtist!.id, artist.id);
    expect(state.error, isNull);
  });
}

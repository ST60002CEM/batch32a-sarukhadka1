import 'package:dartz/dartz.dart';
import 'package:final_assignment/features/home/domain/entity/artist_entity.dart';
import 'package:final_assignment/features/home/domain/usecases/artist_usecase.dart';
import 'package:final_assignment/features/home/presentation/viewmodel/artist_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'artist_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ArtistUseCase>()])
void main() {
  late ArtistUseCase mockArtistUseCase;
  late ProviderContainer container;

  setUp(() {
    mockArtistUseCase = MockArtistUseCase();
    container = ProviderContainer(
      overrides: [
        artistViewModelProvider.overrideWith(
          (ref) => ArtistViewmodel(artistUsecase: mockArtistUseCase),
        ),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('Pagination should correctly handle new data', () async {
    when(mockArtistUseCase.pagination(any, any))
        .thenAnswer((_) async => const Right([
              ArtistEntity(
                id: '1',
                artistName: 'Artist 1',
                artistRate: 5,
                artistImage: 'Image1.jpg',
                artistDescription: 'Description 1',
                artistGenre: 'Genre 1',
              ),
              ArtistEntity(
                id: '2',
                artistName: 'Artist 2',
                artistRate: 4,
                artistImage: 'Image2.jpg',
                artistDescription: 'Description 2',
                artistGenre: 'Genre 2',
              ),
            ]));

    final viewModel = container.read(artistViewModelProvider.notifier);
    await viewModel.getArtists();

    // Assertions to verify state changes
    final state = container.read(artistViewModelProvider);
    expect(state.isLoading, false);
    expect(state.artists.isNotEmpty, true);
    expect(state.artists.length, 2);
    expect(state.page, equals(1)); // Assuming initial page is 1
  });

  test('Pagination should handle empty data by setting hasReachedMax',
      () async {
    when(mockArtistUseCase.pagination(any, any))
        .thenAnswer((_) async => const Right([]));

    final viewModel = container.read(artistViewModelProvider.notifier);
    await viewModel.getArtists();

    // Assertions to verify handling of empty data
    final state = container.read(artistViewModelProvider);
    expect(state.hasReachedMax, true);
    expect(state.isLoading, true);
  });

  test('resetState should correctly reset the state and fetch initial data',
      () async {
    when(mockArtistUseCase.pagination(any, any)).thenAnswer(
      (_) async => const Right([
        ArtistEntity(
          id: '1',
          artistName: 'Artist 1',
          artistRate: 5,
          artistImage: 'Image1.jpg',
          artistDescription: 'Description 1',
          artistGenre: 'Genre 1',
        ),
      ]),
    );

    final viewModel = container.read(artistViewModelProvider.notifier);

    // Simulate state change before reset
    await viewModel.getArtists();

    // Reset the state
    await viewModel.resetState();

    // Assertions to verify state reset and fetching initial data
    final state = container.read(artistViewModelProvider);
    expect(state.isLoading, isFalse);
    expect(state.artists.isNotEmpty, isTrue);
    expect(state.page,
        equals(1)); // Assuming initial page is 1 and it's incremented
  });
}

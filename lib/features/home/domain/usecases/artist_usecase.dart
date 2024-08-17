import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/home/domain/entity/artist_entity.dart';
import 'package:final_assignment/features/home/domain/repository/artist_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final artistUsecaseProvider = Provider<ArtistUseCase>((ref) {
  final artistRepository = ref.watch(artistRepositoryProvider);
  return ArtistUseCase(artistRepository: artistRepository);
});

class ArtistUseCase {
  final IArtistRepository artistRepository;

  ArtistUseCase({required this.artistRepository});

  Future<Either<Failure, List<ArtistEntity>>> pagination(int? page, int? limit)  {
    return  artistRepository.pagination(page??1, limit??10);
  }

// get single product
  Future<Either<Failure, ArtistEntity>> getArtistById(String id) {
    return artistRepository.getArtistById(id);
  }

}

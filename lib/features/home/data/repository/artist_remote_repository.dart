import 'package:dartz/dartz.dart';

import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/home/data/data_source/remote/artist_remote_data_source.dart';


import 'package:final_assignment/features/home/domain/entity/artist_entity.dart';

import 'package:final_assignment/features/home/domain/repository/artist_repository.dart';


import 'package:flutter_riverpod/flutter_riverpod.dart';

final artistRemoteRepository = Provider<IArtistRepository>((ref) {
  final artistRemoteDataSource = ref.watch(artistRemoteDataSourceProvider);
  return ArtistRemoteRepository(
      artistRemoteDataSource: artistRemoteDataSource);
});

class ArtistRemoteRepository implements IArtistRepository {
  final ArtistRemoteDataSource artistRemoteDataSource;

  ArtistRemoteRepository({required this.artistRemoteDataSource});

  @override
  Future<Either<Failure, List<ArtistEntity>>> pagination(int page, int limit) {
    return artistRemoteDataSource.pagination(page: page, limit: limit);
  }
  
  
}


import 'package:dartz/dartz.dart';

import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/home/data/repository/artist_remote_repository.dart';

import 'package:final_assignment/features/home/domain/entity/artist_entity.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final artistRepositoryProvider = Provider<IArtistRepository>((ref)=>
  ref.read (artistRemoteRepository));

abstract class IArtistRepository {
  Future<Either<Failure,List<ArtistEntity>>> pagination(int page, int limit);
  

  Future<Either<Failure, ArtistEntity>> getArtistById(String id);
}


import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/failure/failure.dart';

import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/home/data/dto/pagination_dto.dart';
import 'package:final_assignment/features/home/data/model/artist_api_model.dart';
import 'package:final_assignment/features/home/domain/entity/artist_entity.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final artistRemoteDataSourceProvider = Provider<ArtistRemoteDataSource>((ref) {
  final dio = ref.watch(httpServiceProvider);
  final artistApiModel = ref.watch(artistApiModelProvider);
  final userSharedPrefs = ref.watch(userSharedPrefsProvider);
  return ArtistRemoteDataSource(
    dio: dio,
    artistApiModel: artistApiModel,
    userSharedPrefs: userSharedPrefs,
  );
});

class ArtistRemoteDataSource {
  final Dio dio;
  final ArtistApiModel artistApiModel;
  final UserSharedPrefs userSharedPrefs;

  ArtistRemoteDataSource({
    required this.dio,
    required this.artistApiModel,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, List<ArtistEntity>>> pagination(
      {required int page, required int limit}) async {
    try {
      final token = await userSharedPrefs.getUserToken();
      token.fold((l) => throw Failure(error: l.error), (r) => r);
      final response = await dio.get(
        ApiEndpoints.paginatonArtist,
        queryParameters: {
          'page': page,
          'limit': limit,
        },
        options: Options(
          headers: {
            'authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 201) {
        final paginationDto = PaginationDto.fromJson(response.data);
        return Right(artistApiModel.toEntityList(paginationDto.artists));
      }
      return Left(Failure(
          error: response.data['message'],
          statusCode: response.statusCode.toString()));
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    }
  }
}

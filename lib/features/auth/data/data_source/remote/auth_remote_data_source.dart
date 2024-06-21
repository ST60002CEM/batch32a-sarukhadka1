// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:final_assignment/app/constants/api_endpoint.dart';
// import 'package:final_assignment/core/failure/failure.dart';
// import 'package:final_assignment/core/networking/remote/http_service.dart';
// import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
// import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final authRemoteDataSourceProvider = Provider(
//   (ref) => AuthRemoteDataSource(
//     dio: ref.read(httpServiceProvider),
//     userSharedPrefs: ref.read(userSharedPrefsProvider),
//   ),
// );

// class AuthRemoteDataSource {
//   final Dio dio;
//   final UserSharedPrefs userSharedPrefs;

//   AuthRemoteDataSource({required this.dio, required this.userSharedPrefs});

//   Future<Either<Failure, bool>> createUser(AuthEntity createUser) async {
//     try {
//       Response response = await dio.post(
//         ApiEndpoints.createUser,
//         data: {
//           "firstName": createUser.firstName,
//           "lastName": createUser.lastName,
//           "email": createUser.email,
//           "phoneNumber": createUser.phone,
//           "password": createUser.password,
//         },
//       );
//       if (response.statusCode == 200) {
//         return const Right(true);
//       } else {
//         return Left(
//           Failure(
//             error: response.data['message'],
//             statusCode: response.statusCode.toString(),
//           ),
//         );
//       }
//     } on DioException catch (e) {
//       return Left(Failure(
//         error: e.toString(),
//         statusCode: e.response?.statusCode.toString() ?? '0',
//       ));
//     }
//   }

//   Future<Either<Failure, bool>> loginUser(
//     String email,
//     String password,
//   ) async {
//     try{
//       Response response = await dio.post(
//         ApiEndpoints.loginUser,
//         data: {
//           "email": email,
//           "password": password,
//         },
//       );
//       if(response.statusCode ==200){
//         String token = response.data['token'];

//         await userSharedPrefs.setUserToken(token);
//         return const Right(true);
//       }else{
//         return Left(
//           Failure(
//             error: response.data['message'],
//             statusCode: response.statusCode.toString(),
//           ),
//         );
//       }
//     } on DioException catch(e){
//       return Left(Failure(
//         error: e.toString(),
//         statusCode: e.response?.statusCode.toString() ?? '0',
//       ));
//     }
//   }
// }
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/auth/data/model/auth_api_model.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSource(
    dio: ref.watch(httpServiceProvider),
    authApiModel: ref.watch(authApiModelProvider),
    userSharedPrefs: ref.watch(userSharedPrefsProvider),
  ),
);

class AuthRemoteDataSource {
  final Dio dio;
  final AuthApiModel authApiModel;
  final UserSharedPrefs userSharedPrefs;

  AuthRemoteDataSource({
    required this.userSharedPrefs,
    required this.dio,
    required this.authApiModel,
  });

  Future<Either<Failure, bool>> registerUser(AuthEntity authEntity) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.createUser,
        data: authApiModel.fromEntity(authEntity).toJson(),
      );
      if (response.statusCode == 201) {
        return const Right(true);
      }
      return Left(
        Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString()),
      );
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    }
  }

  Future<Either<Failure, bool>> loginUser(
      {required String email, required String password}) async {
    try {
      Response response = await dio.post(ApiEndpoints.loginUser,
          data: {'email': email, 'password': password});

      if (response.statusCode == 201) {
        final token = response.data['token'];
        await userSharedPrefs.setUserToken(token);

        return const Right(true);
      }

      return Left(Failure(
          error: response.data['message'],
          statusCode: response.statusCode.toString()));
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/domain/repository/i_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRemoteRepositoryProvider = Provider(
  (ref) => AuthRemoteRepository(
    ref.read(authRemoteDataSourceProvider),
  ),
);

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  AuthRemoteRepository(this._authRemoteDataSource);

  @override
  Future<Either<Failure, bool>> createUser(AuthEntity user) {
    return _authRemoteDataSource.registerUser(user);
  }

  @override
  Future<Either<Failure, bool>> loginUser(String email, String password) {
    return _authRemoteDataSource.loginUser(email: email, password: password);
  }

  @override
  Future<Either<Failure, bool>> verifyUser() {
    return _authRemoteDataSource.verifyUser();
  }
 
  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() {
    return _authRemoteDataSource.getMe();
  }
 
  @override
  Future<Either<Failure, bool>> fingerPrintLogin(String id) {
    return _authRemoteDataSource.fingerPrintLogin(id);
  }
 
 
}

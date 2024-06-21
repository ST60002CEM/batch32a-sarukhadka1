import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/auth/data/repository/auth_remote_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
 
 
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
 
 
final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  return ref.read(authRemoteRepositoryProvider);
});
abstract class IAuthRepository{
  Future<Either<Failure, bool>> createUser(AuthEntity user);
  Future<Either<Failure, bool>> loginUser(String email, String password);
}
import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/domain/repository/i_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
 
final authUseCaseProvider = Provider<AuthUseCase>((ref) {
  return AuthUseCase(authRepository: ref.watch(authRepositoryProvider));
});
 
class AuthUseCase {
  final IAuthRepository authRepository;
 
  AuthUseCase({required this.authRepository});
 
  Future<Either<Failure, bool>> createUser(AuthEntity auth) {
    return authRepository.createUser(auth);
  }
  Future<Either<Failure, bool>> loginUser(
    String? email, String? password) {
    return authRepository.loginUser(email??"", password??"");
  }
}
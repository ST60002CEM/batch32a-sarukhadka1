import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/domain/repository/i_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authUseCaseProvider = Provider<AuthUseCase>((ref) {
  return AuthUseCase(authRepository: ref.watch(authRepositoryProvider),userSharedprefs: ref.watch(userSharedPrefsProvider));
});

class AuthUseCase {
  
  final IAuthRepository authRepository;
  final UserSharedPrefs userSharedprefs;

  AuthUseCase({required this.authRepository, required this.userSharedprefs});

  // AuthUseCase({required this.authRepository},);

  Future<Either<Failure, bool>> createUser(AuthEntity? auth) {
    return authRepository.createUser(auth!);
  }

  Future<Either<Failure, bool>> loginUser(String? email, String? password) {
    return authRepository.loginUser(email ?? "", password ?? "");
  }

  Future<Either<Failure, bool>> verifyUser() {
    return authRepository.verifyUser();
  }
 
  Future<Either<Failure, AuthEntity>> getCurrentUser() {
    return authRepository.getCurrentUser();
  }
 
  Future<Either<Failure, bool>> fingerPrintLogin() async {
    final data = await userSharedprefs.checkId();
    return data.fold((l) => Left(Failure(error: l.error)), (r) async {
      if (r != '') {
        await authRepository.fingerPrintLogin(r);
        return const Right(true);
      }
      return Left(Failure(error: 'No fingerprint id found'));
    });
  }
}

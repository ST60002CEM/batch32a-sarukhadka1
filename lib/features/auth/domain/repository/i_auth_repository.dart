import 'package:final_assignment/core/common/provider/internet_connectivity.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/auth/data/repository/auth_local_repository.dart';
import 'package:final_assignment/features/auth/data/repository/auth_remote_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';

import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  //Check internet connectivity
  final checkConnectivity = ref.read(connectivityStatusProvider);

  if (checkConnectivity == ConnectivityStatus.isConnected) {
  return ref.read(authRemoteRepositoryProvider);
  } else {
    return ref.read(authLocalRepositoryProvider);
  }
});

abstract class IAuthRepository {
  Future<Either<Failure, bool>> createUser(AuthEntity user);
  Future<Either<Failure, bool>> loginUser(String email, String password);
}

import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/domain/usecases/auth_usecase.dart';
import 'package:final_assignment/features/auth/presentation/navigator/login_navigator.dart';
import 'package:final_assignment/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
  MockSpec<LoginViewNavigator>(),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AuthUseCase mockAuthUseCase;
  late ProviderContainer container;
  late LoginViewNavigator mockLoginViewNavigator;

  setUp(() {
    mockAuthUseCase = MockAuthUseCase();
    mockLoginViewNavigator = MockLoginViewNavigator();
    container = ProviderContainer(
      overrides: [
        authViewModelProvider.overrideWith(
          (ref) => AuthViewModel(mockLoginViewNavigator, mockAuthUseCase),
        ),
      ],
    );
  });

  tearDown(
    () {
      container.dispose();
    },
  );

  test('check for the initial state in Auth state', () {
    //Arrange
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
    expect(authState.error, null);
  });

  test('login test with valid username and password', () async {
    const correctUsername = 'saru21';
    const correctPassword = 'saru21';

    when(mockAuthUseCase.loginUser(any, any)).thenAnswer((invocation) {
      final username = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      return Future.value(
        username == correctUsername && password == correctPassword
            ? const Right(true)
            : Left(Failure(error: 'Invalid username or password')),
      );
    });

    //Act
    await container
        .read(authViewModelProvider.notifier)
        .loginUser('saru21', 'saru21');

    final authState = container.read(authViewModelProvider);

    //Assert
    expect(authState.error, isNull);
  });

  test("Register auth with valid credentials", () async {
    //Arrange
    when(mockAuthUseCase.createUser(any)).thenAnswer((invocation) {
      final auth = invocation.positionalArguments[0] as AuthEntity;
      return Future.value(
        auth.firstName.isNotEmpty &&
                auth.lastName.isNotEmpty &&
                auth.email.isNotEmpty &&
                auth.password.isNotEmpty &&
                auth.email.contains('@') &&
                auth.email.contains('.') &&
                auth.phone == 10
            ? const Right(true)
            : Left(
                Failure(error: 'Invalid'),
              ),
      );
    });

    //Act
    await container
        .read(authViewModelProvider.notifier)
        .createUser(const AuthEntity(
          firstName: 'saru',
          lastName: 'khadka',
          email: 'saru@gmail',
          phone: 1234567899,
          password: '123456',
        ));

    final state = container.read(authViewModelProvider);

    //Assert
    expect(state.isLoading, true);
    expect(state.error, null);
  });
  tearDown(() {
    container.dispose();
  });
}

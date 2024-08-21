import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures.dart';
import 'package:e_commerce_app/features/auth/data/models/user_model.dart';
import 'package:e_commerce_app/features/auth/presentation/bloc/bloc/user_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockLoginUsecase mockLoginUsecase;
  late MockSignupUsecase mockSignupUsecase;
  late MockLogoutUsecase mockLogoutUsecase;
  late MockGetMeUsecase mockGetMeUsecase;
  late UserBloc userBloc;

  setUp(() {
    mockLogoutUsecase = MockLogoutUsecase();
    mockSignupUsecase = MockSignupUsecase();
    mockLoginUsecase = MockLoginUsecase();
    mockGetMeUsecase = MockGetMeUsecase();
    userBloc = UserBloc(
        loginUsecase: mockLoginUsecase,
        logoutUsecase: mockLogoutUsecase,
        signupUsecase: mockSignupUsecase,
        getMeUsecase: mockGetMeUsecase);
  });

  test('should test if initial state is empty', () {
    expect(userBloc.state, InitialState());
  });

  const String name = 'name';
  const String email = 'email@example.com';
  const String password = 'password';
  const String access_token = 'access_token';
  const String id = 'id';

  UserModel userModel = UserModel(
      email: email,
      password: password,
      id: id,
      accestoken: access_token,
      name: name);

  blocTest<UserBloc, UserState>(
      'should emit Logged State when the user logged in succesfully',
      build: () {
        when(mockLoginUsecase.login(email, password))
            .thenAnswer((_) async => const Right(access_token));
        return userBloc;
      },
      act: (bloc) =>
          bloc.add(const LoginEvent(email: email, password: password)),
      wait: const Duration(milliseconds: 500),
      expect: () => const [LoadingState(), LoggedState()]);

  blocTest<UserBloc, UserState>(
      'should emit an error state when the login fails',
      build: () {
        when(mockLoginUsecase.login(email, password)).thenAnswer(
            (_) async => const Left(ServerFailure('an error occured')));
        return userBloc;
      },
      act: (bloc) =>
          bloc.add(const LoginEvent(email: email, password: password)),
      wait: const Duration(milliseconds: 500),
      expect: () =>
          const [LoadingState(), ErrorState(message: 'an error occured')]);

  blocTest<UserBloc, UserState>(
      'should emit [Loading state, Registered State] when the user register succesfully',
      build: () {
        when(mockSignupUsecase.signup(name, email, password))
            .thenAnswer((_) async => const Right(true));
        return userBloc;
      },
      act: (bloc) => bloc
          .add(const SignupEvent(name: name, email: email, password: password)),
      wait: const Duration(milliseconds: 500),
      expect: () => const [LoadingState(), RegisteredState()]);

  blocTest<UserBloc, UserState>(
      'should emit [Loading State, Error State] when the registeration fails',
      build: () {
        when(mockSignupUsecase.signup(name, email, password)).thenAnswer(
            (_) async => const Left(ServerFailure('an error occured')));
        return userBloc;
      },
      act: (bloc) => bloc
          .add(const SignupEvent(name: name, email: email, password: password)),
      wait: const Duration(milliseconds: 500),
      expect: () =>
          const [LoadingState(), ErrorState(message: 'an error occured')]);

  blocTest<UserBloc, UserState>(
    'should emit [Loading state, Loggedout State] when the user successfully logged out',
    build: () {
      when(mockLogoutUsecase.logout())
          .thenAnswer((_) async => const Right(true));
      return userBloc;
    },
    act: (bloc) => bloc.add(LogoutEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => const [LoadingState(), LoggedOutState()],
  );

  blocTest<UserBloc, UserState>(
    'should emit [Loading state, Error State] when the user successfully logged out',
    build: () {
      when(mockLogoutUsecase.logout()).thenAnswer(
          (_) async => const Left(ServerFailure('an error occured')));
      return userBloc;
    },
    act: (bloc) => bloc.add(LogoutEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () =>
        const [LoadingState(), ErrorState(message: 'an error occured')],
  );

  blocTest(
    'should emit [Loading state, LoadedUserInfo state] when the user information is loaded succesfully',
    build: () {
      when(mockGetMeUsecase.getme()).thenAnswer((_) async => Right(userModel));
      return userBloc;
    },
    act: (bloc) => bloc.add(GetmeEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => [const LoadingState(), LoadedUserInfo(userModel: userModel)],
  );
}

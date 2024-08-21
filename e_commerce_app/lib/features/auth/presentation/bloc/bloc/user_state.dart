part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class InitialState extends UserState {}

final class LoadingState extends UserState {
  const LoadingState();
  @override
  List<Object> get props => [];
}

final class LoggedState extends UserState {
  const LoggedState();
  @override
  List<Object> get props => [];
}

final class LoggedOutState extends UserState {
  const LoggedOutState();
  @override
  List<Object> get props => [];
}

final class RegisteredState extends UserState {
  const RegisteredState();
  @override
  List<Object> get props => [];
}

final class LoadedUserInfo extends UserState {
  final UserModel userModel;

  const LoadedUserInfo({required this.userModel});
  @override
  List<Object> get props => [];
}

final class ErrorState extends UserState {
  final String message;

  const ErrorState({required this.message});
  @override
  List<Object> get props => [message];
}

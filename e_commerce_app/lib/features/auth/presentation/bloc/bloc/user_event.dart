part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends UserEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});
}

class SignupEvent extends UserEvent {
  final String name;
  final String email;
  final String password;

  const SignupEvent(
      {required this.name, required this.email, required this.password});
}

class LogoutEvent extends UserEvent {}

class GetmeEvent extends UserEvent {}

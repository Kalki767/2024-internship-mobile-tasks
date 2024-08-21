import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/user_model.dart';
import '../../../domain/usecases/get_me_usecase.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../../../domain/usecases/logout_usecase.dart';
import '../../../domain/usecases/signup_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final LoginUsecase _loginUsecase;
  final LogoutUsecase _logoutUsecase;
  final SignupUsecase _signupUsecase;
  final GetMeUsecase _getMeUsecase;

  UserBloc(
      {required LoginUsecase loginUsecase,
      required LogoutUsecase logoutUsecase,
      required SignupUsecase signupUsecase,
      required GetMeUsecase getMeUsecase})
      : _loginUsecase = loginUsecase,
        _logoutUsecase = logoutUsecase,
        _signupUsecase = signupUsecase,
        _getMeUsecase = getMeUsecase,
        super(InitialState()) {
    on<LoginEvent>((event, emit) async {
      emit(const LoadingState());

      final result = await _loginUsecase.login(event.email, event.password);

      result.fold((failure) {
        emit(const ErrorState(message: 'an error occured'));
      }, (data) {
        emit(const LoggedState());
      });
    });

    on<LogoutEvent>((event, emit) async {
      emit(const LoadingState());

      final result = await _logoutUsecase.logout();

      result.fold((failure) {
        emit(const ErrorState(message: 'an error occured'));
      }, (data) {
        emit(const LoggedOutState());
      });
    });

    on<SignupEvent>((event, emit) async {
      emit(const LoadingState());

      final result =
          await _signupUsecase.signup(event.name, event.email, event.password);

      result.fold((failure) {
        emit(const ErrorState(message: 'an error occured'));
      }, (data) {
        emit(const RegisteredState());
      });
    });

    on<GetmeEvent>((event, emit) async {
      emit(const LoadingState());

      final result = await _getMeUsecase.getme();

      result.fold((failure) {
        emit(const ErrorState(message: 'an error occured'));
      }, (data) {
        emit(LoadedUserInfo(userModel: data));
      });
    });
  }
}

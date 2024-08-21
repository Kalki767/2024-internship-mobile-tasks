import 'package:e_commerce_app/features/auth/data/data_sources/local_datasource.dart';
import 'package:e_commerce_app/features/auth/data/data_sources/remote_datasource.dart';
import 'package:e_commerce_app/features/auth/domain/repositories/user_repository.dart';
import 'package:e_commerce_app/features/auth/domain/usecases/get_me_usecase.dart';
import 'package:e_commerce_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:e_commerce_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:e_commerce_app/features/auth/domain/usecases/signup_usecase.dart';

import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

@GenerateMocks(
  [
    UserRemoteDataSource,
    UserRepository,
    LoginUsecase,
    LogoutUsecase,
    SignupUsecase,
    UserLocalDataSource,
    GetMeUsecase,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}

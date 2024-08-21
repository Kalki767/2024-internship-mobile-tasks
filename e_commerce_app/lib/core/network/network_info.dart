import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool>
      get isConnected; // function to check if we are connected to the internet or not
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker _connectionChecker;

  //Constructior of the class intialized with InternetConnection checker
  NetworkInfoImpl({required InternetConnectionChecker connectionChecker})
      : _connectionChecker = connectionChecker;

  @override
  Future<bool> get isConnected => _connectionChecker
      .hasConnection; //The methond in the abstract which determines whether we are connected to netwrok or not
}

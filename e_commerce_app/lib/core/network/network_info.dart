import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool>
      get isConnected; // function to check if we are connected to the internet or not
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  //Constructior of the class intialized with InternetConnection checker
  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker
      .hasConnection; //The methond in the abstract which determines whether we are connected to netwrok or not
}

import 'package:e_commerce_app/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  /*create instances of the class that we will mock and instance of 
  Mockinternetchecker to mock the network*/
  late NetworkInfoImpl networkInfoImpl;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(mockInternetConnectionChecker);
  });

  //test to check if we have succesfully implemented the network info class
  test('check if it is connected to internet', () async {
    //arrange
    final hasconnection = Future.value(true);
    when(mockInternetConnectionChecker.hasConnection)
        .thenAnswer((_) => hasconnection);

    //act
    final result = networkInfoImpl.isConnected;

    //assert
    verify(mockInternetConnectionChecker.hasConnection);
    expect(result, hasconnection);
  });
}

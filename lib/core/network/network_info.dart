import 'package:data_connection_checker/data_connection_checker.dart' show DataConnectionChecker;

abstract class NetworkInfo { // NetworkInfo -> Network, network -> /
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}

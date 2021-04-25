import 'package:data_connection_checker/data_connection_checker.dart' show DataConnectionChecker;

abstract class Network {
  Future<bool> get isConnected;
}

class NetworkImpl implements Network {
  final DataConnectionChecker connectionChecker;

  NetworkImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}

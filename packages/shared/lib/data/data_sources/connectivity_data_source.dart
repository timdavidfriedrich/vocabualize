import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

abstract class ConnectivityDataSource {
  Stream<bool> watchIsConnected();
}

@Injectable(as: ConnectivityDataSource)
class const ConnectivityDataSourceImpl() implements ConnectivityDataSource {
  @override
  Stream<bool> watchIsConnected() => _watchConnections().map(_hasNetwork).distinct();

  Stream<List<ConnectivityResult>> _watchConnections() async* {
    final connectivity = Connectivity();
    yield await connectivity.checkConnectivity();
    yield* connectivity.onConnectivityChanged;
  }

  bool _hasNetwork(List<ConnectivityResult> connections) =>
      connections.any((connection) => connection != ConnectivityResult.none);
}

import 'package:shared/data/models/local_snapshot.dart';

abstract class LocalImportDataSource {
  Future<void> importSnapshot(LocalSnapshot snapshot);
}

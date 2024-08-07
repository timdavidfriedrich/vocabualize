import 'package:get_it/get_it.dart';
import 'package:vocabualize/src/common/service_locator/service_locator.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  initializeCommonDependencies(sl);
}

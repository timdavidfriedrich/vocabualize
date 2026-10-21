import 'package:core/config/build_config.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio dio() => Dio(BaseOptions(baseUrl: apiBaseUrl));
}

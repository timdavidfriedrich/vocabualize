import 'package:core/di/core_module.module.dart';
import 'package:feature_collections/di/feature_collections_module.module.dart';
import 'package:feature_details/di/feature_details_module.module.dart';
import 'package:feature_home/di/feature_home_module.module.dart';
import 'package:feature_practice/di/feature_practice_module.module.dart';
import 'package:feature_scan/di/feature_scan_module.module.dart';
import 'package:feature_welcome/di/feature_welcome_module.module.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/di/shared_module.module.dart';
import 'package:vocabualize/src/di/service_locator.config.dart';

final sl = GetIt.instance;

@InjectableInit(
  externalPackageModulesBefore: [
    ExternalModule(CorePackageModule),
    ExternalModule(SharedPackageModule),
    ExternalModule(FeatureHomePackageModule),
    ExternalModule(FeatureWelcomePackageModule),
    ExternalModule(FeatureDetailsPackageModule),
    ExternalModule(FeaturePracticePackageModule),
    ExternalModule(FeatureCollectionsPackageModule),
    ExternalModule(FeatureScanPackageModule),
  ],
)
Future<void> configureDependencies() async => sl.init();

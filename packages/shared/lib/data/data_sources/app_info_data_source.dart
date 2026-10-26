import 'dart:io';
import 'dart:ui';

import 'package:app_settings/app_settings.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

const _playStoreHost = "play.google.com";
const _playStoreListingPath = "/store/apps/details";
const _playStorePackageParameter = "id";

abstract class AppInfoDataSource {
  Future<int> buildNumber();

  Future<String> appVersion();

  Future<String> platformVersion();

  Future<bool> openStoreListing();

  String deviceLanguageCode();

  Future<void> openDateSettings();

  Future<void> openAppSettings();

  Future<void> openInternetSettings();

  Future<void> openNotificationSettings();
}

@Injectable(as: AppInfoDataSource)
class const AppInfoDataSourceImpl() implements AppInfoDataSource {
  @override
  Future<int> buildNumber() async => int.parse((await PackageInfo.fromPlatform()).buildNumber);

  @override
  Future<String> appVersion() async {
    final info = await PackageInfo.fromPlatform();
    return "${info.version}+${info.buildNumber}";
  }

  @override
  Future<String> platformVersion() async {
    if (!Platform.isAndroid) return Platform.operatingSystem;
    final android = await DeviceInfoPlugin().androidInfo;
    return "Android ${android.version.release} (SDK ${android.version.sdkInt})";
  }

  @override
  Future<bool> openStoreListing() async {
    final packageName = (await PackageInfo.fromPlatform()).packageName;
    return launchUrl(
      Uri.https(_playStoreHost, _playStoreListingPath, {_playStorePackageParameter: packageName}),
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  String deviceLanguageCode() => PlatformDispatcher.instance.locale.languageCode;

  @override
  Future<void> openDateSettings() => AppSettings.openAppSettings(type: AppSettingsType.date);

  @override
  Future<void> openAppSettings() => AppSettings.openAppSettings();

  @override
  Future<void> openNotificationSettings() =>
      AppSettings.openAppSettings(type: AppSettingsType.notification);

  @override
  Future<void> openInternetSettings() =>
      AppSettings.openAppSettingsPanel(AppSettingsPanelType.internetConnectivity);
}

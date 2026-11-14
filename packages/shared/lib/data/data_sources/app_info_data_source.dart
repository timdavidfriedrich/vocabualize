abstract class AppInfoDataSource {
  Future<int> buildNumber();

  Future<String> appVersion();

  Future<String> platformVersion();

  Future<bool> openStoreListing();

  String deviceLanguageCode();

  String deviceLocaleTag();

  Future<void> openDateSettings();

  Future<void> openAppSettings();

  Future<void> openInternetSettings();

  Future<void> openNotificationSettings();
}

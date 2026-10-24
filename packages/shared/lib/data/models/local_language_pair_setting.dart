import 'package:dart_mappable/dart_mappable.dart';

part 'local_language_pair_setting.mapper.dart';

@MappableClass()
class const LocalLanguagePairSetting({
  required final String source,
  required final String target,
}) with LocalLanguagePairSettingMappable;

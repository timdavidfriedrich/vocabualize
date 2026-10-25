import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class ExternalLinkDataSource {
  Future<bool> open(Uri uri);
}

@Injectable(as: ExternalLinkDataSource)
class const ExternalLinkDataSourceImpl() implements ExternalLinkDataSource {
  @override
  Future<bool> open(Uri uri) => launchUrl(uri, mode: LaunchMode.externalApplication);
}

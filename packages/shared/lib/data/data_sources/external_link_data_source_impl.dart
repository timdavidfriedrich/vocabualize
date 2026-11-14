import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/external_link_data_source.dart';
import 'package:url_launcher/url_launcher.dart';

@Injectable(as: ExternalLinkDataSource)
class const ExternalLinkDataSourceImpl() implements ExternalLinkDataSource {
  @override
  Future<bool> open(Uri uri) => launchUrl(uri, mode: LaunchMode.externalApplication);
}

import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/activity_local_data_source.dart';
import 'package:shared/data/data_sources/database_session_data_source.dart';
import 'package:shared/domain/extensions/stream_extensions.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

@Injectable(as: ActivityLocalDataSource)
class const ActivityLocalDataSourceImpl(
  final DatabaseSessionDataSource _sessions,
) implements ActivityLocalDataSource {
  @override
  Stream<List<LocalActivity>> watchActivities() {
    return _sessions.watchSession().switchMap(
      (session) => session == null
          ? Stream.value(const <LocalActivity>[])
          : LocalActivity.db
                .watch(session, limit: 1)
                .asyncMap((_) => LocalActivity.db.find(session)),
    );
  }
}

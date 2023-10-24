import 'package:pocketbase/pocketbase.dart';

class PocketBaseModel {
  final Map<String, dynamic> data;

  PocketBaseModel.fromRecordModel(RecordModel recordModel) : data = recordModel.data {
    data.addAll({"id": recordModel.id});
    data.addAll({"created": recordModel.created});
    data.addAll({"updated": recordModel.updated});
  }
}

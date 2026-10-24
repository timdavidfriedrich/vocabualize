import 'package:shared/domain/entities/image_pick_source.dart';

sealed class DetailsEvent {
  const DetailsEvent();
}

class const DetailsImagePickRequested({
  required final ImagePickSource source,
}) extends DetailsEvent;

class const DetailsImageRemoved() extends DetailsEvent;

class const DetailsSaveRequested({
  required final String source,
  required final String target,
}) extends DetailsEvent;

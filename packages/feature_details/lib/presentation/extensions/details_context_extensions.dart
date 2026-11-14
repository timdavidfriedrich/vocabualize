import 'package:feature_details/presentation/details_bloc.dart';
import 'package:feature_details/presentation/details_event.dart';
import 'package:feature_details/presentation/widgets/image_source_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension DetailsContextExtensions on BuildContext {
  Future<void> pickPhoto() async {
    final bloc = read<DetailsBloc>();
    final source = await requestsImagePickSource(this);
    if (source != null) bloc.add(DetailsPhotoPickRequested(source: source));
  }
}

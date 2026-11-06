import 'package:flutter/material.dart';
import 'package:shared/domain/entities/default_gather_option.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

extension DefaultGatherOptionExtensions on DefaultGatherOption {
  String toLabel(BuildContext context) => switch (this) {
    DefaultGatherOption.none => context.s.settingsDefaultGatherNone,
    DefaultGatherOption.scan => context.s.homeScanButton,
    DefaultGatherOption.write => context.s.homeWriteButton,
  };

  IconData? toIcon() => switch (this) {
    DefaultGatherOption.none => null,
    DefaultGatherOption.scan => Icons.camera_alt_rounded,
    DefaultGatherOption.write => Icons.edit_rounded,
  };

  DefaultGatherOption withImagesHidden(bool areImagesHidden) => switch (this) {
    DefaultGatherOption.scan when areImagesHidden => DefaultGatherOption.none,
    _ => this,
  };
}

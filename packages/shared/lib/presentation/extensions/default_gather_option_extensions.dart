import 'package:flutter/material.dart';
import 'package:shared/domain/entities/default_gather_option.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

extension DefaultGatherOptionExtensions on DefaultGatherOption {
  String toLabel(BuildContext context) => switch (this) {
    DefaultGatherOption.none => context.s.settingsDefaultGatherNone,
    DefaultGatherOption.scan => context.s.homeScanButton,
    DefaultGatherOption.write => context.s.homeWriteButton,
  };

  DefaultGatherOption withImagesHidden(bool areImagesHidden) => switch (this) {
    DefaultGatherOption.scan when areImagesHidden => DefaultGatherOption.none,
    _ => this,
  };
}

import 'dart:io';

import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _defaultRadius = Spacing.l;

class const AccountAvatar({
  super.key,
  required final String? _picturePath,
  final double _radius = _defaultRadius,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pictureWidth = (_radius * 2 * MediaQuery.devicePixelRatioOf(context)).round();
    final picture = switch (_picturePath) {
      final path? => ResizeImage(FileImage(File(path)), width: pictureWidth),
      null => null,
    };
    return CircleAvatar(
      radius: _radius,
      backgroundColor: context.c.primary,
      foregroundImage: picture,
      onForegroundImageError: picture == null ? null : (error, stackTrace) {},
      child: Icon(Icons.person_rounded, color: context.c.onPrimary),
    );
  }
}

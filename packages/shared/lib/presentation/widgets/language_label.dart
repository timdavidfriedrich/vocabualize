import 'package:flutter/material.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';

class const LanguageLabel({
  super.key,
  required final Language _language,
  final TextStyle? _style,
  final bool _showsName = true,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      _showsName ? "${_language.toFlag()} ${_language.toLabel(context)}" : _language.toFlag(),
      style: _style,
      overflow: TextOverflow.ellipsis,
    );
  }
}

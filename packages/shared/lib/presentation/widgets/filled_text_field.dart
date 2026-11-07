import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

class const FilledTextField({
  super.key,
  final TextEditingController? _controller,
  final FocusNode? _focusNode,
  final String? _hintText,
  final Widget? _prefix,
  final Widget? _suffix,
  final TextStyle? _style,
  final bool _autofocus = false,
  final bool _isCorrectionDisabled = false,
  final TextInputAction? _textInputAction,
  final ValueChanged<String>? _onSubmitted,
  final ValueChanged<String>? _onChanged,
  final GestureTapCallback? _onTap,
  final TapRegionCallback? _onTapOutside,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(Spacing.radiusXl),
      borderSide: BorderSide.none,
    );
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      autofocus: _autofocus,
      autocorrect: !_isCorrectionDisabled,
      enableSuggestions: !_isCorrectionDisabled,
      style: _style,
      textInputAction: _textInputAction,
      onSubmitted: _onSubmitted,
      onChanged: _onChanged,
      onTap: _onTap,
      onTapOutside: _onTapOutside,
      decoration: InputDecoration(
        hintText: _hintText,
        filled: true,
        fillColor: context.c.surfaceContainerHighest,
        prefixIcon: _prefix,
        suffixIcon: _suffix,
        contentPadding: const EdgeInsets.symmetric(horizontal: Spacing.l, vertical: Spacing.m),
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        disabledBorder: border,
      ),
    );
  }
}

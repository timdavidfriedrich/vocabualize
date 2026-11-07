import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/filled_text_field.dart';

const _height = Spacing.xxxl + Spacing.xs;

class const SendTextField({
  super.key,
  required final ValueChanged<String> _onSubmitted,
  final TextEditingController? _controller,
  final String? _hintText,
  final Widget? _prefix,
  final String? _initialText,
  final FocusNode? _focusNode,
  final bool _autofocus = false,
  final bool _isCorrectionDisabled = false,
  final GestureTapCallback? _onTap,
  final TapRegionCallback? _onTapOutside,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final ownController = useTextEditingController(text: _initialText);
    final controller = _controller ?? ownController;
    final hasText = useListenableSelector(controller, () => controller.text.trim().isNotEmpty);
    void submit() {
      if (hasText) _onSubmitted(controller.text.trim());
    }

    return SizedBox(
      height: _height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Center(
              child: FilledTextField(
                controller: controller,
                focusNode: _focusNode,
                hintText: _hintText,
                prefix: _prefix,
                autofocus: _autofocus,
                isRound: true,
                isCorrectionDisabled: _isCorrectionDisabled,
                textInputAction: TextInputAction.go,
                onSubmitted: (_) => submit(),
                onTap: _onTap,
                onTapOutside: _onTapOutside,
              ),
            ),
          ),
          const SizedBox(width: Spacing.s),
          AspectRatio(
            aspectRatio: 1,
            child: IconButton.filled(
              style: IconButton.styleFrom(
                backgroundColor: context.c.primary,
                foregroundColor: context.c.onPrimary,
                disabledBackgroundColor: context.c.surfaceContainerHighest,
                disabledForegroundColor: context.c.outline,
                shape: const CircleBorder(),
              ),
              onPressed: hasText ? submit : null,
              tooltip: context.s.submit,
              icon: const Icon(Icons.arrow_forward_rounded),
            ),
          ),
        ],
      ),
    );
  }
}

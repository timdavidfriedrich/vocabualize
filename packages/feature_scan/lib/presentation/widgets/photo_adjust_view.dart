import 'dart:io';
import 'dart:math';

import 'package:core/theme/spacing.dart';
import 'package:feature_scan/presentation/extensions/image_provider_extensions.dart';
import 'package:feature_scan/presentation/scan_bloc.dart';
import 'package:feature_scan/presentation/scan_event.dart';
import 'package:feature_scan/presentation/widgets/camera_round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/image_crop.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/button_progress.dart';
import 'package:shared/presentation/widgets/tonal_button.dart';

const _maxScale = 5.0;
const _frameInset = Spacing.s + Spacing.borderWidthThick;

class const PhotoAdjustView({
  super.key,
  required final String _path,
  required final bool _isProcessing,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final image = useMemoized(() => FileImage(File(_path)), [_path]);
    final imageSize = useFuture(useMemoized(image.resolveSize, [image])).data;
    return LayoutBuilder(
      builder: (context, constraints) => _AdjustContent(
        image: image,
        imageSize: imageSize,
        side: constraints.maxWidth - 2 * _frameInset,
        isProcessing: _isProcessing,
      ),
    );
  }
}

class const _AdjustContent({
  required final ImageProvider _image,
  required final Size? _imageSize,
  required final double _side,
  required final bool _isProcessing,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useTransformationController();
    final bloc = context.read<ScanBloc>();
    final imageSize = _imageSize;
    final coverScale = switch (imageSize) {
      final size? => _side / min(size.width, size.height),
      null => 1.0,
    };
    final contentSize = (imageSize ?? Size.square(_side)) * coverScale;
    void reset() => controller.value = Matrix4.translationValues(
      -(contentSize.width - _side) / 2,
      -(contentSize.height - _side) / 2,
      0,
    );
    useEffect(() {
      reset();
      return null;
    }, [_side, imageSize]);
    void confirm() {
      final matrix = controller.value;
      final scale = matrix.getMaxScaleOnAxis();
      final translation = matrix.getTranslation();
      final visible = _side / scale;
      bloc.add(
        ScanPhotoConfirmed(
          crop: ImageCrop(
            left: (-translation.x / scale / contentSize.width).clamp(0, 1),
            top: (-translation.y / scale / contentSize.height).clamp(0, 1),
            width: (visible / contentSize.width).clamp(0, 1),
            height: (visible / contentSize.height).clamp(0, 1),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.xs),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CameraRoundButton(
                icon: Icons.arrow_back_rounded,
                tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                onPressed: _isProcessing ? null : () => bloc.add(const ScanRetakeRequested()),
              ),
              CameraRoundButton(
                icon: Icons.replay_rounded,
                tooltip: context.s.scanResetCropTooltip,
                onPressed: _isProcessing || imageSize == null ? null : reset,
              ),
            ],
          ),
        ),
        const SizedBox(height: Spacing.s),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.s),
          child: AspectRatio(
            aspectRatio: 1,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Spacing.radiusXxl),
                border: Border.all(color: context.c.primary, width: Spacing.borderWidthThick),
              ),
              child: Padding(
                padding: const EdgeInsets.all(Spacing.borderWidthThick),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Spacing.radiusXxl - Spacing.borderWidthThick),
                  child: imageSize == null
                      ? const Center(child: CircularProgressIndicator())
                      : InteractiveViewer(
                          transformationController: controller,
                          constrained: false,
                          minScale: 1,
                          maxScale: _maxScale,
                          panEnabled: !_isProcessing,
                          scaleEnabled: !_isProcessing,
                          child: SizedBox.fromSize(
                            size: contentSize,
                            child: Image(image: _image, fit: BoxFit.fill),
                          ),
                        ),
                ),
              ),
            ),
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.fromLTRB(Spacing.m, 0, Spacing.m, Spacing.m),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton.icon(
                onPressed: _isProcessing || imageSize == null ? null : confirm,
                icon: _isProcessing ? const ButtonProgress() : const Icon(Icons.check_rounded),
                label: Text(context.s.scanUsePhotoButton),
              ),
              const SizedBox(height: Spacing.s),
              TonalButton(
                onPressed: _isProcessing ? null : () => bloc.add(const ScanRetakeRequested()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.replay_rounded),
                    const SizedBox(width: Spacing.xs),
                    Text(context.s.scanRetakeButton),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

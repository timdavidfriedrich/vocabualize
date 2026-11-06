import 'package:core/theme/spacing.dart';
import 'package:feature_scan/presentation/scan_bloc.dart';
import 'package:feature_scan/presentation/scan_event.dart';
import 'package:feature_scan/presentation/scan_state.dart';
import 'package:feature_scan/presentation/widgets/camera_preview_box.dart';
import 'package:feature_scan/presentation/widgets/camera_round_button.dart';
import 'package:feature_scan/presentation/widgets/scan_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _shutterSize = Spacing.xxxxl + Spacing.l;
const _sideButtonSize = Spacing.xxxl + Spacing.xs;
const _controlOpacity = 0.12;

class const ScanCameraView({
  super.key,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final camera = useScanCamera();
    final bloc = context.read<ScanBloc>();
    final isProcessing = context.select<ScanBloc, bool>(
      (bloc) => switch (bloc.state) {
        ScanCapturing(:final isProcessing) => isProcessing,
        ScanReviewing() => false,
      },
    );
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
                onPressed: () => Navigator.of(context).maybePop(),
              ),
              CameraRoundButton(
                icon: camera.isFlashOn ? Icons.flash_on_rounded : Icons.flash_off_rounded,
                tooltip: context.s.scanFlashTooltip,
                isActive: camera.isFlashOn,
                onPressed: camera.isReady ? camera.toggleFlash : null,
              ),
            ],
          ),
        ),
        const SizedBox(height: Spacing.s),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.s),
          child: AspectRatio(aspectRatio: 1, child: CameraPreviewBox(camera: camera)),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.fromLTRB(Spacing.xxl, 0, Spacing.xxl, Spacing.xxl),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _GalleryButton(
                onPressed: isProcessing ? null : () => bloc.add(const ScanGalleryRequested()),
              ),
              _ShutterButton(
                isBusy: camera.isTakingPicture || isProcessing,
                onPressed: camera.isReady ? () => _takePhoto(context, camera) : null,
              ),
              CameraRoundButton(
                icon: Icons.cameraswitch_outlined,
                tooltip: context.s.scanSwitchCameraTooltip,
                size: _sideButtonSize,
                onPressed: camera.canSwitch ? camera.switchLens : null,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _takePhoto(BuildContext context, ScanCamera camera) async {
    final bloc = context.read<ScanBloc>();
    final path = await camera.takePicture();
    if (path != null) bloc.add(ScanPhotoTaken(path: path));
  }
}

class const _GalleryButton({
  required final VoidCallback? _onPressed,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: _sideButtonSize,
      child: Material(
        color: context.overlay.onScrim.withValues(alpha: _controlOpacity),
        borderRadius: BorderRadius.circular(Spacing.radiusL),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: _onPressed,
          child: Icon(
            Icons.photo_library_outlined,
            color: context.overlay.onScrim,
            semanticLabel: context.s.scanGalleryTooltip,
          ),
        ),
      ),
    );
  }
}

class const _ShutterButton({
  required final bool _isBusy,
  required final VoidCallback? _onPressed,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: context.s.scanShutterTooltip,
      child: GestureDetector(
        onTap: _isBusy ? null : _onPressed,
        child: Container(
          width: _shutterSize,
          height: _shutterSize,
          padding: const EdgeInsets.all(Spacing.xxs),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: context.overlay.onScrim, width: Spacing.borderWidthHeavy),
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _onPressed == null
                  ? context.overlay.onScrim.withValues(alpha: _controlOpacity)
                  : context.overlay.onScrim,
            ),
            child: _isBusy
                ? Padding(
                    padding: const EdgeInsets.all(Spacing.m),
                    child: CircularProgressIndicator(color: context.overlay.scrim),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class const ShrinkableBox({
  super.key,
  required final double _minimumHeight,
  required super.child,
}) extends SingleChildRenderObjectWidget {
  @override
  RenderObject createRenderObject(BuildContext context) => _RenderShrinkableBox(_minimumHeight);

  @override
  void updateRenderObject(BuildContext context, RenderObject renderObject) {
    if (renderObject case final _RenderShrinkableBox box) box.minimumHeight = _minimumHeight;
  }
}

class _RenderShrinkableBox extends RenderProxyBox {
  _RenderShrinkableBox(this._minimumHeight);

  double _minimumHeight;

  set minimumHeight(double value) {
    if (value == _minimumHeight) return;
    _minimumHeight = value;
    markNeedsLayout();
  }

  @override
  double computeMinIntrinsicHeight(double width) => _minimumHeight;

  @override
  double computeMaxIntrinsicHeight(double width) => _minimumHeight;
}

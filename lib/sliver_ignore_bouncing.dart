import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:sliver_inspector/render_sliver_logger_mixin.dart';

class SliverIgnoreTopBouncing extends SliverToBoxAdapter {
  const SliverIgnoreTopBouncing({
    super.key,
    super.child,
  });

  @override
  RenderSliverToBoxAdapter createRenderObject(BuildContext context) =>
      LogRenderSliverIgnoreTopBouncing(context);
}

class LogRenderSliverIgnoreTopBouncing extends RenderSliverToBoxAdapter
    with RenderSliverLoggerMixin {
  LogRenderSliverIgnoreTopBouncing(
    this.context, {
    super.child,
  });

  @override
  final BuildContext context;

  @override
  void performLayout() {
    if (child == null) {
      geometry = SliverGeometry.zero;
      return;
    }

    final SliverConstraints constraints = this.constraints;
    dispatchSliverConstraints();
    child!.layout(constraints.asBoxConstraints(), parentUsesSize: true);
    final double childExtent;
    switch (constraints.axis) {
      case Axis.horizontal:
        childExtent = child!.size.width;
        break;
      case Axis.vertical:
        childExtent = child!.size.height;
        break;
    }
    final double paintedChildSize = calculatePaintOffset(constraints, from: 0.0, to: childExtent);
    final double cacheExtent = calculateCacheOffset(constraints, from: 0.0, to: childExtent);

    assert(paintedChildSize.isFinite);
    assert(paintedChildSize >= 0.0);
    geometry = SliverGeometry(
      paintOrigin: constraints.overlap,
      scrollExtent: childExtent,
      paintExtent: paintedChildSize,
      cacheExtent: cacheExtent,
      maxPaintExtent: childExtent,
      hitTestExtent: paintedChildSize,
      hasVisualOverflow:
          childExtent > constraints.remainingPaintExtent || constraints.scrollOffset > 0.0,
    );
    dispatchSliverGeometry();
    setChildParentData(child!, constraints, geometry!);
  }
}

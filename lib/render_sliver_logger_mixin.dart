import 'package:flutter/rendering.dart';

mixin RenderSliverLoggerMixin on RenderSliver {
  ValueChanged<SliverConstraints>? get onConstraints;

  ValueChanged<SliverGeometry>? get onGeometry;

  @override
  void performLayout() {
    onConstraints?.call(constraints);
    super.performLayout();
    onGeometry?.call(geometry!);
  }
}

const fractionDigits = 2;
extension SliverConstraintsExt on SliverConstraints {

  Map<String, String> get table {
    return {
      'scrollOffset': scrollOffset.toStringAsFixed(fractionDigits),
      'precedingScrollExtent': precedingScrollExtent.toStringAsFixed(fractionDigits),
      'overlap': overlap.toStringAsFixed(fractionDigits),
      'remainingPaintExtent': remainingPaintExtent.toStringAsFixed(fractionDigits),
      'crossAxisExtent': crossAxisExtent.toStringAsFixed(fractionDigits),
      'viewportMainAxisExtent': viewportMainAxisExtent.toStringAsFixed(fractionDigits),
      'remainingCacheExtent': remainingCacheExtent.toStringAsFixed(fractionDigits),
      'cacheOrigin': cacheOrigin.toStringAsFixed(fractionDigits),
      'axisDirection': axisDirection.name,
      'growthDirection': growthDirection.name,
      'userScrollDirection': userScrollDirection.name,
      'crossAxisDirection': crossAxisDirection.name,
    };
  }
}


extension SliverGeometryExt on SliverGeometry {
  Map<String, String> get table {
    return {
      'scrollExtent': scrollExtent.toStringAsFixed(fractionDigits),
      'paintOrigin': paintOrigin.toStringAsFixed(fractionDigits),
      'paintExtent': paintExtent.toStringAsFixed(fractionDigits),
      'layoutExtent': layoutExtent.toStringAsFixed(fractionDigits),
      'maxPaintExtent': maxPaintExtent.toStringAsFixed(fractionDigits),
      'maxScrollObstructionExtent': maxScrollObstructionExtent.toStringAsFixed(fractionDigits),
      'hitTestExtent': hitTestExtent.toStringAsFixed(fractionDigits),
      'scrollOffsetCorrection': '${scrollOffsetCorrection?.toStringAsFixed(fractionDigits)}',
      'cacheExtent': cacheExtent.toStringAsFixed(fractionDigits),
      'visible': visible.toString(),
      'hasVisualOverflow': hasVisualOverflow.toString(),
    };
  }
}
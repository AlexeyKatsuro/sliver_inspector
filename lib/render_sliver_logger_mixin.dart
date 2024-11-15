import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

abstract class SliverNotification extends Notification {}

class SliverConstraintsNotification extends SliverNotification {
  final SliverConstraints constraints;

  SliverConstraintsNotification(this.constraints);
}

class SliverGeometryNotification extends SliverNotification {
  final SliverGeometry sliverGeometry;

  SliverGeometryNotification(this.sliverGeometry);
}

mixin RenderSliverLoggerMixin on RenderSliver {
  BuildContext get context;

  void dispatchSliverConstraints() {
    SliverConstraintsNotification(constraints).dispatch(context);
  }

  void dispatchSliverGeometry() {

    if (geometry case final geometry?) {
      SliverGeometryNotification(geometry).dispatch(context);
    }
  }

  @override
  void performLayout() {
    dispatchSliverConstraints();
    super.performLayout();
    dispatchSliverGeometry();
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

class SliverNotificationListener extends NotificationListener<SliverNotification> {
  SliverNotificationListener({
    super.key,
    required super.child,
    ValueChanged<SliverConstraints>? onConstraints,
    ValueChanged<SliverGeometry>? onGeometry,
  }) : super(
          onNotification: (notification) {
            switch (notification) {
              case SliverConstraintsNotification():
                onConstraints?.call(notification.constraints);
                return onConstraints != null;
              case SliverGeometryNotification():
                onGeometry?.call(notification.sliverGeometry);
                return onGeometry != null;
              default:
                return false;
            }
          },
        );
}

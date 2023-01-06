import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:sliver_inspector/render_sliver_logger_mixin.dart';

class LogSliverToBoxAdapter extends SliverToBoxAdapter {
  /// Creates a sliver that contains a single box widget.
  const LogSliverToBoxAdapter({
    super.key,
    super.child,
    this.onConstraints,
    this.onGeometry,
  });

  final ValueChanged<SliverConstraints>? onConstraints;
  final ValueChanged<SliverGeometry>? onGeometry;

  @override
  RenderSliverToBoxAdapter createRenderObject(BuildContext context) =>
      LogRenderSliverToBoxAdapter(onConstraints, onGeometry);
}

class LogRenderSliverToBoxAdapter extends RenderSliverToBoxAdapter with RenderSliverLoggerMixin {
  /// Creates a [RenderSliver] that wraps a [RenderBox].
  LogRenderSliverToBoxAdapter(
    this.onConstraints,
    this.onGeometry, {
    super.child,
  });

  @override
  final ValueChanged<SliverConstraints>? onConstraints;
  @override
  final ValueChanged<SliverGeometry>? onGeometry;

}

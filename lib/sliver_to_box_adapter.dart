import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:sliver_inspector/render_sliver_logger_mixin.dart';

class LogSliverToBoxAdapter extends SliverToBoxAdapter {
  /// Creates a sliver that contains a single box widget.
  const LogSliverToBoxAdapter({
    super.key,
    super.child,
  });


  @override
  RenderSliverToBoxAdapter createRenderObject(BuildContext context) =>
      LogRenderSliverToBoxAdapter(context);
}

class LogRenderSliverToBoxAdapter extends RenderSliverToBoxAdapter with RenderSliverLoggerMixin {
  /// Creates a [RenderSliver] that wraps a [RenderBox].
  LogRenderSliverToBoxAdapter(
    this.context, {
    super.child,
  });

  @override
  final BuildContext context;
}

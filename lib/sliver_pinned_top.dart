import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:sliver_inspector/render_sliver_logger_mixin.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:sliver_tools/src/rendering/sliver_pinned_header.dart';

class LogSliverPinnedHeader extends SliverPinnedHeader {
  const LogSliverPinnedHeader({
    super.key,
    this.onConstraints,
    this.onGeometry,
    required super.child,
  });

  final ValueChanged<SliverConstraints>? onConstraints;
  final ValueChanged<SliverGeometry>? onGeometry;

  @override
  RenderSliverPinnedHeader createRenderObject(BuildContext context) =>
      LogRenderSliverPinnedHeader(context);
}

class LogRenderSliverPinnedHeader extends RenderSliverPinnedHeader with RenderSliverLoggerMixin {
  LogRenderSliverPinnedHeader(this.context);

  @override
  final BuildContext context;
}

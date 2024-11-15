import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:sliver_inspector/render_sliver_logger_mixin.dart';

class LogSliverFillRemaining extends SliverFillRemaining {
  const LogSliverFillRemaining({
    super.key,
    super.child,
    super.hasScrollBody = true,
    super.fillOverscroll = false,
  });

  @override
  Widget build(BuildContext context) {
    if (hasScrollBody) {
      return _SliverFillRemainingWithScrollable(child: child);
    }
    if (!fillOverscroll) {
      return _SliverFillRemainingWithoutScrollable(child: child);
    }
    return _SliverFillRemainingAndOverscroll(child: child);
  }
}

class _SliverFillRemainingWithScrollable extends SingleChildRenderObjectWidget {
  const _SliverFillRemainingWithScrollable({
    super.child,
  });

  @override
  RenderSliverFillRemainingWithScrollable createRenderObject(BuildContext context) =>
      LogRenderSliverFillRemainingWithScrollable(context);
}

class LogRenderSliverFillRemainingWithScrollable extends RenderSliverFillRemainingWithScrollable
    with RenderSliverLoggerMixin {
  @override
  final BuildContext context;

  LogRenderSliverFillRemainingWithScrollable(this.context);
}

class _SliverFillRemainingWithoutScrollable extends SingleChildRenderObjectWidget {
  const _SliverFillRemainingWithoutScrollable({
    super.child,
  });

  @override
  RenderSliverFillRemaining createRenderObject(BuildContext context) =>
      LogRenderSliverFillRemaining(context);
}

class LogRenderSliverFillRemaining extends RenderSliverFillRemaining with RenderSliverLoggerMixin {
  @override
  final BuildContext context;

  LogRenderSliverFillRemaining(this.context);
}

class _SliverFillRemainingAndOverscroll extends SingleChildRenderObjectWidget {
  const _SliverFillRemainingAndOverscroll({
    super.child,
  });

  @override
  RenderSliverFillRemainingAndOverscroll createRenderObject(BuildContext context) =>
      LogRenderSliverFillRemainingAndOverscroll(context);
}

class LogRenderSliverFillRemainingAndOverscroll extends RenderSliverFillRemainingAndOverscroll
    with RenderSliverLoggerMixin {
  @override
  final BuildContext context;

  LogRenderSliverFillRemainingAndOverscroll(this.context);
}

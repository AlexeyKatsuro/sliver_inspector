import 'package:flutter/cupertino.dart';

class PostFrameBuilder extends StatefulWidget {
  const PostFrameBuilder({super.key, required this.builder, required this.listenable, this.child});

  final TransitionBuilder builder;

  final Listenable listenable;

  final Widget? child;

  @override
  State<PostFrameBuilder> createState() => _PostFrameBuilderState();
}

class _PostFrameBuilderState extends State<PostFrameBuilder> {
  @override
  void initState() {
    super.initState();
    widget.listenable.addListener(_handleChange);
  }

  @override
  void didUpdateWidget(PostFrameBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.listenable != oldWidget.listenable) {
      oldWidget.listenable.removeListener(_handleChange);
      widget.listenable.addListener(_handleChange);
    }
  }

  @override
  void dispose() {
    widget.listenable.removeListener(_handleChange);
    super.dispose();
  }

  void _handleChange() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.child);
  }
}

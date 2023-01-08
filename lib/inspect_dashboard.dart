import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'post_frame_builder.dart';
import 'render_sliver_logger_mixin.dart';

class InspectDashboard extends StatelessWidget {
  const InspectDashboard({super.key, required this.controller});

  final InspectDashboardController controller;
  
  Map<String, SliverConstraints> get constraints => controller._constraints;

  Map<String, SliverGeometry> get geometry => controller._geometry;

  Set<String> get tags => controller._tags;

  Iterable<String> get visibleTags => tags.where(((element) {
        return !controller._hidedTags.contains(element);
      }));

  Map<String, String> constraintsFor(String tag) => constraints[tag]?.table ?? {};

  Map<String, String> geometryFor(String tag) => geometry[tag]?.table ?? {};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // AnimatedBuilder
    return PostFrameBuilder(
      listenable: controller,
      builder: (context, _) {
        return ListView(
          children: [
            for (final tag in visibleTags) ...[
              Text(tag, style: theme.textTheme.headline5),
              _Table(
                name: 'SliverConstraints',
                data: constraintsFor(tag),
              ),
              _Table(
                name: 'SliverGeometry',
                data: geometryFor(tag),
              )
            ],
          ],
        );
      }
    );
  }
}


class _Table extends StatelessWidget {
  const _Table({super.key, required this.name, required this.data});

  final String name;
  final Map<String, String> data;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      expandedAlignment: Alignment.topLeft,
      title: Text(name),
      tilePadding: EdgeInsets.symmetric(horizontal: 0),
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Table(
            defaultColumnWidth: IntrinsicColumnWidth(),
            children: [
              for (final property in ((data).entries))
                TableRow(children: [Text(property.key), SizedBox(width: 10), Text(property.value)]),
            ],
          ),
        ),
      ],
    );
  }
}

class InspectDashboardController extends ChangeNotifier {

  final Set<String> _tags = {};

  final Set<String> _hidedTags = {};

  final Map<String, SliverConstraints> _constraints = {};

  final Map<String, SliverGeometry> _geometry = {};

  void setConstraints(String tag, SliverConstraints value) {
    _tags.add(tag);
    _constraints[tag] = value;
    notifyListeners();
  }

  void setGeometry(String tag, SliverGeometry value) {
    _tags.add(tag);
    _geometry[tag] = value;
    notifyListeners();
  }

  void setTagVisibility(String tag, {required bool visible}) {
    bool shouldNotify = false;
    if (visible) {
      shouldNotify = _hidedTags.remove(tag);
    } else {
      shouldNotify = _hidedTags.add(tag);
    }
   notifyListeners();
  }

  bool isTagVisible(String tag) {
   return !_hidedTags.contains(tag);
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sliver_inspector/sliver_ignore_bouncing.dart';
import 'package:sliver_inspector/sliver_pinned_top.dart';
import 'package:sliver_inspector/sliver_to_box_adapter.dart';

import 'inspect_dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final InspectDashboardController controller = InspectDashboardController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverIgnoreTopBouncing(
                  onConstraints: (value) {
                    controller.setConstraints('red', value);
                  },
                  onGeometry: (value) {
                    controller.setGeometry('red', value);
                  },
                  child: TextBox.red(height: 150,),
                ),
                SliverList(delegate: SliverChildBuilderDelegate((context, index) => TextBox(height: index  <25 ? 100 : Random().nextInt(100).toDouble()),childCount: 1000)),
                // SliverList(delegate: SliverChildBuilderDelegate((context, index) => TextBox(),childCount: 50)),
                // ...List.filled(100, LogSliverToBoxAdapter(child: TextBox())),
                SliverIgnoreTopBouncing(
                  onConstraints: (value) {
                    controller.setConstraints('green', value);
                  },
                  onGeometry: (value) {
                    controller.setGeometry('green', value);
                  },
                  child: TextBox.green(),
                ),

                // ...List.filled(10, LogSliverToBoxAdapter(child: TextBox())),

                //...List.filled(1, LogSliverToBoxAdapter(child: TextBox())),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: InspectDashboard(
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}

class TextBox extends StatefulWidget {
  const TextBox({
    super.key,
    this.color = Colors.black26,
    this.height = 100,
    this.tag,
  });

  const TextBox.red({
    super.key,
    this.color = Colors.red,
    this.height = 100,
    this.tag = 'red',
  });

  const TextBox.green({
    super.key,
    this.color = Colors.green,
    this.height = 100,
    this.tag = 'green',
  });

  final String? tag;
  final Color color;
  final double height;

  @override
  State<TextBox> createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  @override
  Widget build(BuildContext context) {
    final controller = context.findAncestorStateOfType<_HomePageState>()!.controller;
    final isVisible = controller.isTagVisible(widget.tag ?? '');
    return GestureDetector(
      onTap: () {
        if (widget.tag != null) {
          controller.setTagVisibility(widget.tag!, visible: !isVisible);
          setState(() {});
        }
      },
      child: Container(
        height: widget.height,
        decoration: BoxDecoration(color: widget.color),
        child: Row(
          children: [
            if (widget.tag != null)
              Checkbox(
                value: isVisible,
                onChanged: (value) {
                  controller.setTagVisibility(widget.tag!, visible: value!);
                },
              ),
            Expanded(
              child: FittedBox(
                child: Text(widget.tag ?? 'Text'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

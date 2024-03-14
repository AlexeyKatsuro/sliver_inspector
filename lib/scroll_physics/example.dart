import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Physics playground',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  List<int> items = List.generate(50, (index) => index);

  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  )..repeat(reverse: true);

  int? animationItem = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBar(
          title: Text('Physics'),
        ),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
          cacheExtent: 0,
          itemBuilder: (context, index) {
            final item = items[index];
            Widget child = SizedBox(
              height: 100,
              child: Card(
                key: ValueKey(item),
                child: ListTile(
                  title: Text(
                    'Text $item',
                    style: TextStyle(color: Colors.black87),
                  ),
                  onTap: () {
                    setState(() {
                      animationItem = item;
                    });
                  },
                ),
              ),
            );
            if (item == animationItem) {
              child = AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return SizedBox(
                      height: 50 + 50 * _animationController.value,
                      child: child,
                    );
                  },
                  child: child);
            }
            return child;
          },
          itemCount: items.length),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FilledButton(
              onPressed: () {
                setState(() {
                  items.insert(0, items[0] - 1);
                });
              },
              child: Text('Add first')),
          FilledButton(
              onPressed: () {
                setState(() {
                  items.add(items[items.length - 1] + 1);
                });
              },
              child: Text('Add last')),
          FilledButton(
              onPressed: () {
                setState(() {
                  items.removeAt(0);
                });
              },
              child: Text('Remove first')),
          FilledButton(
              onPressed: () {
                setState(() {
                  items.removeLast();
                });
              },
              child: Text('Remove last')),
          FilledButton(
              onPressed: () {
                setState(() {
                  if (_animationController.isAnimating) {
                    _animationController.stop(canceled: false);
                  } else {
                    _animationController.repeat(reverse: true);
                  }
                });
              },
              child: Text(_animationController.isAnimating ? 'Stop' : 'Start')),
        ],
      ),
    );
  }
}

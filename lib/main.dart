import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class StateManagerWidget extends InheritedWidget {
  const StateManagerWidget(
      {super.key,
      required this.title,
      required this.counter,
      required super.child});

  final String title;
  final int counter;

  static StateManagerWidget of(BuildContext context) {
    final StateManagerWidget? result =
        context.dependOnInheritedWidgetOfExactType<StateManagerWidget>();
    assert(result != null, 'No StateManagerWidget found');
    return result!;
  }

  @override
  bool updateShouldNotify(StateManagerWidget oldWidget) {
    return true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return StateManagerWidget(
      title: 'Counter Demo',
      counter: 0,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StateManagerWidget(
      title: 'Soy el impostor',
      counter: 1,
      child: Scaffold(
        appBar: MyAppbarWidget(myContext: context),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              DisplayCounterWidget(myContextSecond: context),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class DisplayCounterWidget extends StatelessWidget {
  const DisplayCounterWidget({
    super.key,
    required this.myContextSecond,
  });

  final BuildContext myContextSecond;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      child: Text(
        '',
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }
}

class MyAppbarWidget extends StatelessWidget with PreferredSizeWidget {
  const MyAppbarWidget({
    Key? key,
    required this.myContext,
  }) : super(key: key);

  final BuildContext myContext;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(StateManagerWidget.of(myContext).title),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 70.0);
}

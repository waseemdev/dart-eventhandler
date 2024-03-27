import 'package:eventhandler/eventhandler.dart';
import 'package:flutter/material.dart';

import 'events.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EventHandler Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'EventHandler Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    EventHandler()
        .subscribe(_onDecrementCounter)
        .subscribe(_onIncrementCounter);
    super.initState();
  }

  @override
  void dispose() {
    EventHandler()
        .unsubscribe(_onDecrementCounter)
        .unsubscribe(_onIncrementCounter);
    super.dispose();
  }

  void _onIncrementCounter(Increment event) {
    setState(() {
      _counter++;
    });
  }

  void _onDecrementCounter(Decrement event) {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  child: Text("Decrement"),
                  // color: Colors.red,
                  onPressed: () {
                    EventHandler().send(Decrement());
                  },
                ),
                ElevatedButton(
                  child: Text("Increment"),
                  // color: Colors.green,
                  onPressed: () {
                    EventHandler().send(Increment());
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

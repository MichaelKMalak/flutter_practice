import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'dart:math' as math;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Generate Random Words',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  // ignore: unused_field
  int _refreshTimes = 0;
  void _refresh() {
    setState(() {
      _refreshTimes++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return Scaffold(
      backgroundColor:
          Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
              .withOpacity(1.0),
      appBar: AppBar(
        title: Text('Random Words Generator'),
      ),
      body: Center(
          child: Text(
        wordPair.asPascalCase,
        style: Theme.of(context).textTheme.display3,
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _refresh,
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Generate Random Words',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Random Words Generator'),
          ),
          body: Center(
            child: RandomWords(),
          ),
        ));
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return Text(
      wordPair.asPascalCase,
      style: Theme.of(context).textTheme.display3,
    );
  }
}

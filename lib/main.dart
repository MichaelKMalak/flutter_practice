import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Random PascalCase Words',
        home:  RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _randomWords = <WordPair>[];
  final _wordsFont = const TextStyle(fontSize: 18.0);
  final _listPadding = const EdgeInsets.all(16.0);

  Widget _buildListOfRandomWords() {
    return ListView.builder(
        padding: _listPadding,
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          final index = i ~/ 2;
          if (index >= _randomWords.length) {
            _randomWords.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_randomWords[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _wordsFont,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PascalCase Name Generator'),
      ),
      body: _buildListOfRandomWords(),
    );
  }
}

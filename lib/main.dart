import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Name Generator',
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _randomWords = <WordPair>[];
  final Set<WordPair> _savedWords = Set<WordPair>();
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

  Widget _buildRow(WordPair words) {
    final bool isSaved = _savedWords.contains(words);
    return ListTile(
      title: Text(
        words.asPascalCase,
        style: _wordsFont,
      ),
      trailing: Icon(
        isSaved ? Icons.favorite : Icons.favorite_border,
        color: isSaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (isSaved) {
            _savedWords.remove(words);
          } else {
            _savedWords.add(words);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Name Generator'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.list),
              onPressed: _savedWords.isEmpty ? null : _pushSaved),
        ],
      ),
      body: _buildListOfRandomWords(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _savedWords.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _wordsFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Favourites'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}

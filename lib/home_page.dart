import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/message_handler.dart';

import 'model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('To Do'),
          actions: <Widget>[MessageHandler()],
        ),
        body: _buildBody(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("Add new task is pressed!");
          },
          tooltip: 'Add Task',
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('todo').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return _buildList(context, snapshot.data.documents);
        });
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.name),
          trailing: drawCheckIcon(record),
          onTap: () => toggleTaskStatus(record),
        ),
      ),
    );
  }

  Icon drawCheckIcon(Record record) {
    return record.isDone
        ? Icon(
            Icons.check_circle,
            size: 30,
          )
        : Icon(
            Icons.check_circle_outline,
            size: 30,
          );
  }

  toggleTaskStatus(Record record) async {
    Firestore.instance.runTransaction((transaction) async {
      final freshSnapshot = await transaction.get(record.reference);
      final fresh = Record.fromSnapshot(freshSnapshot);

      await transaction.update(record.reference, {'isDone': !fresh.isDone});
    });
  }
}

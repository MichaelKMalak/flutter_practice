import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  final String name;
  final bool isDone;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['isDone'] != null),
        name = map['name'],
        isDone = map['isDone'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}

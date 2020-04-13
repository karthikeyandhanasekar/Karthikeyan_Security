import 'package:chatting/database/firestoreservice.dart';
import 'package:chatting/database/model.dart';
import 'package:chatting/database/path.dart';
import 'package:chatting/firestore.dart';
import 'package:flutter/material.dart';

abstract class Database {
  Future<void> createviewer(Senddata viewer);
  Stream<List<Senddata>> readview();
}

String uniqueid() => DateTime.now().toIso8601String();

final _service = FirestoreService.instance;

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  Future<void> createviewer(Senddata viewer) async {
    return _service.setdata(
      path: APIPath.senddata(phoneNumcontroller.text.trim(), uniqueid()),
      data: viewer.toMap(),
    );
  }

  Stream<List<Senddata>> readview() => _service.collectionStream(
        path: APIPath.readdata(uid),
        builder: (f, documentid) => Senddata.fromMap(f, documentid),
      );
}

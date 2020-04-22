import 'package:chatting/database/firestoreservice.dart';
import 'package:chatting/database/model.dart';
import 'package:chatting/database/path.dart';
import 'package:chatting/firestore.dart';
import 'package:flutter/material.dart';

abstract class Database {
  Future<void> createviewer(Senddata viewer);
  Stream<List<Senddata>> readview();
    Stream<List<Cabdata>>  cabview();

  Stream<List<Deliverydata>> deliveryview();

  Stream<List<Visitordata>> visitorview();

}

String uniqueid() => DateTime.now().toIso8601String();

final _service = FirestoreService.instance;

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid} );
  final String uid;

  Future<void> createviewer(Senddata viewer) async {
    return _service.setdata(
      path: APIPath.senddata(phoneNumcontroller.text.trim(), uniqueid()),
      data: viewer.toMap(),
    );
  }

  Stream<List<Senddata>> readview() => _service.collectionStream(
        path: APIPath.readdata(),
        builder: (f, documentid) => Senddata.fromMap(f, documentid),
      );
      Stream<List<Cabdata>> cabview() => _service.collectionStream(
        path: APIPath.readcab(),
        builder: (f, documentid) => Cabdata.fromMap(f, documentid),
      );
      Stream<List<Deliverydata>> deliveryview() => _service.collectionStream(
        path: APIPath.readdelivery(),
        builder: (f, documentid) => Deliverydata.fromMap(f, documentid),
      );
      Stream<List<Visitordata>> visitorview() => _service.collectionStream(
        path: APIPath.readvisitor(),
        builder: (f, documentid) => Visitordata.fromMap(f, documentid),
      );
}

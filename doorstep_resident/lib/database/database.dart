import 'package:doorstep_resident/database/model.dart';
import 'package:doorstep_resident/database/path.dart';
import 'package:doorstep_resident/firestore.dart';
import 'package:doorstep_resident/signin/register.dart';
import 'package:doorstep_resident/signin/singin.dart';
import 'package:flutter/foundation.dart';
import 'firestoreservice.dart';

abstract class Database {
  Future<void> createviewer(Senddata viewer);
  Stream<List<Senddata>> readview();
}

String uniqueid() => DateTime.now().toIso8601String();

final _service = FirestoreService.instance;

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.email, @required this.blockid})
      : assert(email != null);
  final String email;
  final String blockid;

  Future<void> createviewer(Senddata viewer) async {
    return _service.setdata(
      path: APIPath1.senddata(emailcontroller.text, uniqueid()),
      data: viewer.toMap(),
    );
  }

  Stream<List<Senddata>> readview() => _service.collectionStream(
        path: APIPath.readdata(emailcontrollers.text),
        builder: (f, documentid) => Senddata.fromMap(f, documentid),
      );
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  Future<void> setdata({String path, Map<String, dynamic> data}) async {
    final reference = Firestore.instance.document(path);
    print('$path : $data');
    await reference.setData(data);
  }

  Future<void> regdata({String path, Map<String, dynamic> data}) async {
    final reference = Firestore.instance.document(path);
    print('$path : $data');
    await reference.setData(data);
  }

  Stream<List<L>> regcollectionstream<L>({
    @required String path,
    @required L builder(Map<String, dynamic> data, String documentid),
  }) {
    final reference = Firestore.instance.collection(path);
    final snap = reference.snapshots();
    return snap.map((snapshot) =>
        snapshot.documents.map((r) => builder(r.data, r.documentID)).toList());
  }

  Stream<List<T>> collectionStream<T>({
    @required String path,
    @required T builder(Map<String, dynamic> data, String documentid),
  }) {
    final reference = Firestore.instance.collection(path);
    final snapshots = reference.snapshots();

    return snapshots.map((snapshot) =>
        snapshot.documents.map((f) => builder(f.data, f.documentID)).toList());
  }
}

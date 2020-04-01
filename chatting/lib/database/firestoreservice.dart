import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../firestore.dart';

class FirestoreService
{
  FirestoreService._();
  static final instance = FirestoreService._();


  Future<void> setdata({
   String path,Map<String,dynamic> data}) async
   {
        final reference = Firestore.instance.document(path);
       print( '$path : $data');
        await  reference.setData(data);
   }


   Stream<List<T>> collectionStream<T>(
     {
       @required String path,
       @required T builder(Map<String, dynamic> data,String documentid),
     }
   )
   {
     // final path = APIPath.readdata(uid);
   final reference = Firestore.instance.collection(path);
   final snapshots = reference.snapshots();
   

   return snapshots.map((snapshot) => snapshot.documents.map(
     (f) => builder(f.data, f.documentID)).toList()                                                               
   );

   }
}
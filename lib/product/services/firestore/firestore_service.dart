import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //Veri ekleme
  Future<void> addData(String collection, Map<String, dynamic> data) async {
    try {
      await _db.collection(collection).add(data);
    } catch (e) {
      print(e.toString());
    }
  }

  //Veri okuma
  Stream<QuerySnapshot> getData(String collection) {
    return _db.collection(collection).snapshots();
  }

  //Veri silme
  Future<void> deleteData(String collection, String docId) async {
    try {
      await _db.collection(collection).doc(docId).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  //Veri güncelleme
  Future<void> updateData(
      String collection, String docId, Map<String, dynamic> newData) async {
    try {
      await _db.collection(collection).doc(docId).update(newData);
    } catch (e) {
      print(e.toString());
    }
  }
}

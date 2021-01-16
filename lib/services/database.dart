import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference stressCollection =
      Firestore.instance.collection('Stresses');

//esto lo que hace es updatea O CREA el pedacito de database de cada usuario
  Future updateUserData(String sugars, String name, int strength) async {
    return await stressCollection.document(uid).setData({
      'sugar': sugars,
      'name': name,
      'strength': strength,
    });
  }
}

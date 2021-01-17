import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stressapp/models/stress.dart';
import 'package:stressapp/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference stressCollection =
      Firestore.instance.collection('Stresses');

//esto lo que hace es updatea O CREA el pedacito de database de cada usuario
  Future updateUserData(String description, String name, int stress) async {
    return await stressCollection.document(uid).setData({
      'description': description,
      'name': name,
      'stress': stress,
    });
  }

  //stress list from snapshot
  List<Stress> _stressListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Stress(
          //el ?? es por si no existe que devuelva un string vacio ahi
          name: doc.data['name'] ?? '',
          description: doc.data['description'] ?? '',
          stress: doc.data['stress'] ?? 0);
    }).toList();
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      description: snapshot.data['description'],
      stress: snapshot.data['stress'],
    );
  }

  //get  stress steam
  Stream<List<Stress>> get stress {
    return stressCollection.snapshots().map(_stressListFromSnapshot);
  }

  // Esto toma el cable a firebase de nuestro documento de firebase con el uid, y cada vez que hay un cambio
  //y retorna con la funcion _userDataFromSnapshot el userData
  //get user doc stream
  Stream<UserData> get userData {
    return stressCollection
        .document(uid)
        .snapshots()
        .map(_userDataFromSnapshot);
  }
}

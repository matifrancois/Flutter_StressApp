import 'package:firebase_auth/firebase_auth.dart';
import 'package:stressapp/models/user.dart';
import 'package:stressapp/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //creare user obj based on firebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //Esta parte es la que nos permite saber si alguien se loggeo o si se desloggeo
  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => _userFromFirebaseUser(user));
    //.map(_userFromFirebaseUser); //poner esto o el .map de arriba es lo mismo
  }

  //sing in anon
  Future signInAnon() async {
    //Esta funcion devuelve el usuario o null segun si el signIn fue successful o no
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sing in with emal & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      //aqui se valida que firebase reconozca lo que se envia como un email valido.
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      //aqui se valida que firebase reconozca lo que se envia como un email valido.
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      //create a new document for the user with the uid
      await DatabaseService(uid: user.uid)
          .updateUserData('At Home', 'new stress member', 0);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sing out (retorna Future porque es una tarea asincronica)
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

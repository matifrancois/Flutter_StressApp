class User {
  //con esto guardamos el numero del id del usuario
  final String uid;
  User({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String description;
  final int stress;

  UserData({this.uid, this.name, this.description, this.stress});
}

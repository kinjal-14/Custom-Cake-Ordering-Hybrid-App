class DemoModel {
  String uid;
  String name;
  String phone;
  String email;
  String password;

  DemoModel({required this.uid, required this.name, required this.phone, required this.email, required this.password});

  // receiving  data from server
  factory DemoModel.fromMap(map){
    return DemoModel(
      uid: map['uid'],
      name: map['name'],
      phone: map['phone'],
      email: map['email'],
      password: map['password'],
    );
  }
//sending data to server
  Map<String, dynamic> toMap(){
    return {
      'uid' : uid,
      'name' : name,
      'phone' : phone,
      'email' : email,
      'password' : password,
    };
  }
}
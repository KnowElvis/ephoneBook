import 'package:cloud_firestore/cloud_firestore.dart';

class UsersModel{
  final String? id;
  final String? name;
  final String? phoneNumber;

  UsersModel({this.id, this.name, this.phoneNumber});

  factory UsersModel.fromSnapshot(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;

    return UsersModel(
      name: snapshot['name'],
      phoneNumber: snapshot['phoneNumber'],
      id: snapshot['id']
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'phoneNumber': phoneNumber,
    'id':id
  };
}
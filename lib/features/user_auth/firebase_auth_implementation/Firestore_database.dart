import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ephonebook/features/user_auth/common/toast.dart';
import 'package:ephonebook/models/users_model.dart';

class FirestoreDatabase {
  //CRUD lesson
  //create Data method
  static Future create(UsersModel user) async {
    final userCollection = FirebaseFirestore.instance.collection('users');
    final uid = userCollection.doc().id;
    final collRef = userCollection.doc(uid);
    final newuser = UsersModel(
      id: uid,
      name: user.name,
      phoneNumber: user.phoneNumber,
    ).toJson();

    try {
      await collRef.set(newuser);
    } catch (e) {
      showToast(message: 'Some error occurred $e');
    }
  }

  // Read Data method
  static Stream<List<UsersModel>> read() {
    final userCollection = FirebaseFirestore.instance.collection('users');
    return userCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => UsersModel.fromSnapshot(e)).toList());
  }

  //Update Data method (edit)
  static Future update(UsersModel user) async {
    final userCollection = FirebaseFirestore.instance.collection('users');

    final collRef = userCollection.doc(user.id);
    final newuser = UsersModel(
      id: user.id,
      name: user.name,
      phoneNumber: user.phoneNumber,
    ).toJson();

    try {
      await collRef.update(newuser);
    } catch (e) {
      showToast(message: 'Some error occurred $e');
    }
  }

  //Delete Data method
  static Future delete(UsersModel user) async {
    final userCollection = FirebaseFirestore.instance.collection('users');
    final collRef = userCollection.doc(user.id).delete();
  }
}

import 'package:ephonebook/features/user_auth/common/toast.dart';
import 'package:ephonebook/features/user_auth/firebase_auth_implementation/Firestore_database.dart';
import 'package:ephonebook/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create obj based on firebaseUser
  UserModel? _userFromFirebaseUser(User user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  //method for sign up with email and password
  Future<UserModel?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast(message: 'The email address is already in use.');
      } else {
        showToast(message: 'An error occurred ${e.code}');
      }
    }
    return null;
  }

  //method for the sign in
  Future<UserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showToast(message: 'Invalid email');
      } else if (e.code == 'wrong-password') {
        showToast(message: 'Wrong Password');
      } else {
        showToast(message: 'An error occurred ${e.code}');
      }
    }
    return null;
  }

  // sign in with google
  // Future<User?> signInWithGoogle()async{
  //   final GoogleSignIn _googleSignIn = GoogleSignIn();
  // try{
  //   final GoogleSignInAccount? googleSignInAccount =await _googleSignIn.signIn();
  //   if(googleSignInAccount != null){
  //     final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

  //     final AuthCredential credential =GoogleAuthProvider.credential(
  //       idToken: googleSignInAuthentication.idToken,
  //       accessToken: googleSignInAuthentication.accessToken,
  //     );
  //     await _firebaseAuth.signInWithCredential(credential);
  //   }
  // }catch(e){}
  //   return null;
  // }
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

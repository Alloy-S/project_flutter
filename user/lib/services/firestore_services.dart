import 'package:emart_app/consts/firebase_const.dart';

class FirestoreServices {
  //get user data
  static getUser(uid){
    return firestore.collection(userCollection).where('id',isEqualTo: uid).snapshots();
  }
}
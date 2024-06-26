import 'package:admins/const/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isloading = false.obs;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  
  // login method

  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }

    return userCredential;
  }

  // signup method

  // Future<UserCredential?> signupMethod({email, password, context}) async {
  //   UserCredential? userCredential;

  //   try {
  //     userCredential = await auth.createUserWithEmailAndPassword(
  //         email: emailController.text, password: passwordController.text);
  //   } on FirebaseAuthException catch (e) {
  //     VxToast.show(context, msg: e.toString());
  //   }

  //   return userCredential;
  // }

  // signout method

  signoutMethod(context) async {
    try {
      // currentUser = null;
      await auth.signOut();
      
    } catch(e) {
       VxToast.show(context, msg: e.toString());
    }
  }
}

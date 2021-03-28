import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';
import 'package:images_picker/images_picker.dart';
import 'package:pet_and_vet/constance.dart';
import 'package:pet_and_vet/models/user.dart';
import 'package:pet_and_vet/utils/local_storage/local_sorage.dart';
import 'package:pet_and_vet/view/screens/home_page.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final databaseReference = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors().primary,
        body: FlutterLogin(
          title: 'Pet & Vet',
          logo: 'assets/svg/loginPng.png',
          onLogin: (_) => login(_),
          onSignup: (_) => register(_),
          onSubmitAnimationCompleted: () {
            // Navigator.of(context).pushReplacement(MaterialPageRoute(
            //   builder: (context) => DashboardScreen(),
            // ));
          },
          onRecoverPassword: (_) => Future(null),
          messages: LoginMessages(
            usernameHint: 'email'.tr,
            passwordHint: 'pass'.tr,
            confirmPasswordHint: 'confirm'.tr,
            loginButton: 'login'.tr,
            signupButton: 'register'.tr,
            forgotPasswordButton: '',
            confirmPasswordError: 'notMatch'.tr,
          ),
        ));
  }

  Future<String> login(LoginData user) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: user.name, password: user.password);
      String username = user.name
          .substring(0, user.name.indexOf('@'));
      LocalStorage localStorage = LocalStorage();

      localStorage.saveUser(UserApp(userCredential.user.email, username,userCredential.user.uid));
      localStorage.setLogin(true);
      UserApp aa=await localStorage.user;
      print('user: ${aa.name}');
        Get.off(HomePage(aa));

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<String> register(LoginData user) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: user.name, password: user.password);
      String username = userCredential.user.email
          .substring(0, userCredential.user.email.indexOf('@'));
      print(username);
      LocalStorage localStorage = LocalStorage();
      localStorage.saveUser(UserApp(userCredential.user.email, username,userCredential.user.uid));
      localStorage.setLogin(true);

      databaseReference.child('users').child(userCredential.user.uid).set(
          {
            'uid':userCredential.user.uid,
            'email':userCredential.user.email,
            'name':username,
          }).whenComplete((){
        Get.off(HomePage(UserApp(userCredential.user.email, username,userCredential.user.uid)));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

}

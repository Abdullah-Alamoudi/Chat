import 'dart:io';

import 'package:chat/widget/auth/authform.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
//  const AuthScreen({Key? key}) : super(key: key);
  final _auth = FirebaseAuth.instance;

  bool _isloading = false;

  void _submitAuthForm(String email, String password, String username,
      bool islogin, BuildContext ctx, File? image) async {
    try {
      setState(() {
        _isloading = true;
      });
      UserCredential authresult;
      if (islogin) {
        authresult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authresult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        final ref= FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(authresult.user!.uid + '.jpg'); //for give id uniqe
        await ref.putFile(image!);

        final url=await ref.getDownloadURL();
        
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authresult.user!.uid)
            .set({
              'username': username,
               'password': password,
               'image_url':url
               });
      }
    } on FirebaseAuthException catch (e) {
      String message = 'error Occurred';
      if (e.code == 'weak-password') {
        message = 'the password provided is too ewak';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email';
      } else if (e.code == 'user-not-found') {
        message = 'No user found for that email';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user';
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
      setState(() {
        _isloading = false;
      });
    } catch (e) {
      print(e);
      print('Abdullah');
      setState(() {
        _isloading = false;
      });
    }
  }

  void _sForm(String email, String password, String username,
      bool islogin, BuildContext ctx,) async {
    try {
      setState(() {
        _isloading = true;
      });
      UserCredential authresult;
      if (islogin) {
        authresult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      }
    } on FirebaseAuthException catch (e) {
      String message = 'error Occurred';
        if (e.code == 'user-not-found') {
        message = 'No user found for that email';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user';
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
      setState(() {
        _isloading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AuthForm(
          submitFn: _submitAuthForm,
          sFn: _sForm,
          sloading: _isloading,
        ));
  }
}

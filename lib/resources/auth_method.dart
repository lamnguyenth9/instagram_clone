import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:instagram_clone/model/user.dart' as model;
import 'package:instagram_clone/resources/storage_method.dart';

class AuthMethod{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future<model.UserModel> getUserDetail()async{
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap = await firebaseFirestore.collection("users").doc(currentUser.uid).get();
    return model.UserModel.fromSnapshot(snap);
  }
  Future<String>  signUp({
      required String email,
      required String password,
      required String username,
      required String bio,
      required Uint8List file
      // required Uint8List file
  })async{
    String res = "Something error";
   
     try{
      if(email.isNotEmpty||password.isNotEmpty||username.isNotEmpty||bio.isNotEmpty||file!=null){
       final UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      String photoURL = await StorageMethod().uploadImageToStorage('ProfilePics', file, false);
        model.UserModel user = model.UserModel(
    email: email, 
    uid: credential.user!.uid, 
    photoUrl: photoURL, 
    bio: bio, 
    username: username, 
    followers: [], 
    following: []);
       await firebaseFirestore.collection("users").doc(credential.user!.uid).set(user.toJson());
       print("1");
       res="success";
      }
     }catch(e){
      res= e.toString();
     }
     return res;
  }
  Future<String> login({
    required String email,
    required String password
  }) async{
    String res = "Something got error";
    try{
     if(email.isNotEmpty||password.isNotEmpty){
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      res='success';
     }
     else{
      res='Please enter full field';
     }
    }catch(e){
      res=e.toString();
    }
    return res;
  }
}
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethod{
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> upLoadImage(String childName,Uint8List file, bool isPost)async{
   Reference reference= firebaseStorage.ref().child(childName).child(_auth.currentUser!.uid);
   if(isPost){
    final id = Uuid().v1();
   reference= reference.child(id);
   }
   UploadTask uploadTask = reference.putData(file);
   TaskSnapshot snapshot =  await uploadTask;
   String dowloadURL = await snapshot.ref.getDownloadURL();
   return dowloadURL;
  }
}
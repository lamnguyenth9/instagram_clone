import 'dart:typed_data';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/model/post.dart';
import 'package:instagram_clone/resources/storage_method.dart';

class FirestoreMethod{
  final _firestore= FirebaseFirestore.instance;
  Future<String> upLoad(
    String description,
    Uint8List file,
    String uid,
    String userName,
    
    String profImage,
  
    
    )
    async{
    
    
    var res = "Some error occur";
    try{
        String photoUrl = await StorageMethod().uploadImageToStorage("posts", file, true);
        String postId = Uuid().v1();
      PostModel post =  PostModel(
          description: description, 
          uid: uid, 
          userName: userName, 
          postId: postId, 
          datePublished: DateTime.now(), 
          postUrl: photoUrl, 
          profImage: profImage, 
          like: []);
          _firestore.collection("posts").doc(postId).set(post.toJson());
          res = "success";
    }catch(e){
      res = e.toString();
    }
    return res;
  }
  Future<void> likesPost(String postId, String uid, List likes) async{
     try{
       if(likes.contains(uid)){
       await _firestore.collection("posts").doc(postId).update({
          'like': FieldValue.arrayRemove([uid])
        });
       }else{
       await _firestore.collection("posts").doc(postId).update({
          'like': FieldValue.arrayUnion([uid])
        });
       }
     }catch(e){
      print(e.toString());
     }
  }
  Future<void> PostComment(String postId, String text, String uid, String name, String profilePic) async{
    try{
      String commentId = Uuid().v1();
       if(text.isNotEmpty){
        _firestore.collection('posts').doc(postId).collection("comments").doc(commentId).set({
             'profilePic':profilePic,
             'name':name,
             'uid':uid,
             'text':text,
             'commentId': commentId,
             'datePublished': DateTime.now()
        });
       }
    }catch (e){
      print(e);
    }
  }
  Future<void> deletePost(String postId)async{
    try{
      await _firestore.collection('posts').doc(postId).delete()
;    }catch(e){
      print(e);
    }
  }
}